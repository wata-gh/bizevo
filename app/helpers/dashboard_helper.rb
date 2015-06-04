# Helper methods defined here can be accessed in any controller or view in the application

module Bizevo
  class App
    module DashboardHelper
      def avg_of_times array_of_time
        size = array_of_time.size
        return '--:--' if size == 0
        avg_minutes = array_of_time.map do |x|
          hour, minute = x.split(':')
          hour.to_i * 60 + minute.to_i
        end.inject(:+)/size
        "#{avg_minutes/60}:#{sprintf('%02d', avg_minutes%60)}"
      end

      def calc_dashboard_data range, mst_blg_cd = current_user.user.mst_blg_cd
        blgs = Belonging.where('mst_blg_cd like ?', "#{mst_blg_cd}%").pluck :mst_blg_cd
        wt = Worktime.includes(:user).joins(:user).where(
          :date  => range,
          :users => {:mst_blg_cd => blgs}
        ).order(:psnal_cd, :date)
        awh = {}
        awhm = {}
        rwdh = {}
        twh = {}
        awa = []
        sum = {}
        owa = []
        @hwd = 0
        @o60 = 0
        @aveo = 0.0
        wt.each do |w|
          pc = w.psnal_cd
          unless awh[pc]
            sum[pc] = {
              :starttimes       => [],
              :workdays         => 0,
              :holiday_workdays => 0,
              :worktime         => 0.0,
              :worktimes        => [],
              :overtime         => 0.0,
              :model            => w,
            }
            awh[pc] = []
            awhm[pc] = []
            rwdh[pc] = 0
            twh[pc] = 0
          end
          if /[0-9]{1,2}:[0-5][0-9]/ =~ w.start
            awh[pc] << w.start
            awa << w.start
            sum[pc][:starttimes] << w.start
            if w.calendar != '平日'
              sum[pc][:holiday_workdays] += 1
              @hwd += 1
            else
              sum[pc][:workdays] += 1
            end
            awhm[pc] << w.worked_hours
            twh[pc] += w.worked_hours
            sum[pc][:worktimes] << w.worked_hours
            sum[pc][:worktime] += w.worked_hours
            sum[pc][:overtime] += w.worked_hours - 8.0
          elsif w.calendar == '平日'
            rwdh[pc] += 1
          end
        end

        wc = Worktime.where(
          :psnal_cd   => current_user.description,
          :date       => range,
        ).group(:calendar).count
        twc = 0
        wc.each {|k, v| twc += v}
        tww = wc['平日']

        @awt = avg_of_times awa
        awh.keys.each do |pc|
          ave = awhm[pc].inject(0.0) {|t, v| t + v} / awhm[pc].size
          sum[pc][:ave_worktime] = ave
          sum[pc][:ave_worktime] = 0.0 if sum[pc][:ave_worktime].nan?
          sum[pc][:ave_starttime] = avg_of_times sum[pc][:starttimes]
          sum[pc][:est_worktime] = twh[pc] + rwdh[pc] * ave
          sum[pc][:est_overtime] = (twh[pc] + rwdh[pc] * ave) - tww * 8
          sum[pc][:est_worktime] = 0.0 if sum[pc][:est_worktime].nan?
          sum[pc][:est_overtime] = 0.0 if sum[pc][:est_overtime].nan? || sum[pc][:est_overtime] < 0
          sum[pc][:overtime] = 0.0 if sum[pc][:overtime] < 0
          owa << sum[pc][:est_overtime]
          if (twh[pc] + rwdh[pc] * ave) - tww * 8 >= 60
            @o60 += 1
          end
        end
        @sum = sum.values.sort_by {|s| s[:est_overtime]}.reverse
        @aveo = owa.present? ? owa.inject{|t, v| t + v} / owa.size : 0
      end
    end
    helpers DashboardHelper
  end
end
