class WikiParser

token ITEM_1 ITEM_2 ITEM_3 STRING NEWLINE TABLE DL HEADER_1 HEADER_2 HEADER_3 URL BOLD ITALIC UNDERLINE LINE_THROUGH
options no_result_var
rule
bodys : body {[val[0]]}
      | bodys body {val[0].push(val[1]);val[0]}

body : item1_list
     | item2_list
     | item3_list
     | STRING {[:text,val[0]]}
     | tablediv
     | dl_list
     | header1
     | header2
     | header3
     | url
     | newline
     | bold
     | italic
     | underline
     | line_through

dl_list  : dl {[:dl_list,[val[0]]]}
         | dl_list dl {val[0][1].push(val[1]);val[0]}
dl       : DL {[:dl,dl_parse(val[0])]}

tablediv : table {[:table,[val[0]]]}
         | tablediv table {val[0][1].push(val[1]);val[0]}

table : TABLE {[:row,table_parse(val[0])]}

item1_list : item1 {[:item1_list,[val[0]]]}
           | item1_list item1 {val[0][1].push(val[1]);val[0]}

item1 : ITEM_1 {[:item_1,val[0]]}
      | ITEM_1 item2_list {[:item1,val[0],val[1]]}

item2_list : item2 {[:item2_list,[val[0]]]}
           | item2_list item2 {val[0][1].push(val[1]);val[0]}

item2 : ITEM_2 {[:item_2,val[0]]}
      | ITEM_2 item3_list {[:item2,val[0],val[1]]}

item3_list : item3 {[:item3_list,[val[0]]]}
           | item3_list item3 {val[0][1].push(val[1]);val[0]}

item3 : ITEM_3 {[:item_3,val[0]]}

header1 : HEADER_1 {[:header_1,val[0]]}
header2 : HEADER_2 {[:header_2,val[0]]}
header3 : HEADER_3 {[:header_3,val[0]]}

url : URL {[:url,val[0]]}

bold : BOLD {[:bold,val[0]]}
italic : ITALIC {[:italic,val[0]]}
underline : UNDERLINE {[:underline,val[0]]}
line_through : LINE_THROUGH {[:line_through,val[0]]}

newline : NEWLINE {[:newline,val[0]]}

---- header
---- inner
def table_parse(line)
  tr = []
  line.split('|').each do |d|
    q = []
      until d.empty? do
        case d
        when /\A\*([^\*]+)\*/
          q.push([:BOLD,$1])
        when /\A(https?:\/\/[a-zA-Z0-9\/:%#\$&\?\(\)~\.=\+\-]+)\s*\r/
          q.push([:URL,$1])
        when /\A\s+/
          ;
        when /\A[^\n\*]+/
          word = $&
          q.push [:STRING,word]
        else
          raise RuntimeError, 'must not happen'
        end
        d = $' #'
      end
     tr << q
  end
  tr
end

def dl_parse(line)
  line.split(':')
end

def parse(line)
  @yydebug = false
  @q = []
  until line.empty? do
    case line
    when /\A-([^-\r\n]+)-/
      @q.push([:LINE_THROUGH,$1])
    when /\A-([^-].*)$/
      @q.push([:ITEM_1,$1])
    when /\A--([^-].*)$/
      @q.push([:ITEM_2,$1])
    when /\A---([^-].*)$/
      @q.push([:ITEM_3,$1])
    when /\A\*([^\*\r\n]+)\*/
      @q.push([:BOLD,$1])
    when /\A_([^_\r\n]+)_/
      @q.push([:ITALIC,$1])
    when /\A\+([^\+\r\n]+)\+/
      @q.push([:UNDERLINE,$1])
    when /\A\*([^\*].*)$/
      @q.push([:ITEM_1,$1])
    when /\A\*\*([^\*].*)$/
      @q.push([:ITEM_2,$1])
    when /\A\*\*\*([^\*].*)$/
      @q.push([:ITEM_3,$1])
    when /\A\|(.*)/
      @q.push([:TABLE,$1])
    when /\A\\n\:(.*)/
      @q.push([:DL,$1])
    when /\Ah1. (.*)/
      @q.push([:HEADER_1,$1])
    when /\Ah2. (.*)/
      @q.push([:HEADER_2,$1])
    when /\Ah3. (.*)/
      @q.push([:HEADER_3,$1])
    when /\A(https?:\/\/[a-zA-Z0-9\/:%#\$&\?\(\)~\.=\+\-]+)/
      @q.push([:URL,$1])
    when /\A(\r?\n)\r?\n/
     @q.push([:NEWLINE,$1])
    when /\A\s+/
      ;
    when /\A[^\n\*]+/
      word = $&
      @q.push [:STRING,word]
    else
      raise RuntimeError, "must not happen #{line}"
    end
    line = $' #'
  end
  @q.push [ false, '$' ]
  do_parse()
end

def next_token
   @q.shift
end

---- footer

