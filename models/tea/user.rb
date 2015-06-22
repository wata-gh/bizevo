
module Tea
  class User < ::User
    def as_json opts = {}
      super opts.merge(
        only: ['id', 'name', 'image'],
        methods: ['name', 'image'],
        )
    end
    def name
      self.full_name
    end
    def image
      self.get_thumbnail_path
    end
  end
end
