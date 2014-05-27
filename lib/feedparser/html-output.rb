require 'feedparser'
require 'feedparser/filesizes'

module FeedParser
  class Feed
    def to_html(localtime = true)
      s = ''
      s += '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'
      s += "\n"
      s += "<html>\n"
      s += "<head>\n"
      s += "<title>#{@title.escape_html}</title>\n"
      s += "<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\">\n"
      s += "</head>\n"
      s += "<body>\n"

      s += <<-EOF
<table border="1" width="100%" cellpadding="0" cellspacing="0" borderspacing="0"><tr><td>
<table width="100%" bgcolor="#EDEDED" cellpadding="4" cellspacing="2">
      EOF
      r = ""
      r += "<a href=\"#{@link}\">\n" if @link
      if @title
        r += "<b>#{@title.escape_html}</b>\n"
      elsif @link
        r += "<b>#{@link.escape_html}</b>\n"
      else
        r += "<b>Unnamed feed</b>\n"
      end
      r += "</a>\n" if @link
      headline = "<tr><td align=\"right\"><b>%s</b></td>\n<td width=\"100%%\">%s</td></tr>"
      s += (headline % ["Feed title:", r])
      s += (headline % ["Type:", @type])
      s += (headline % ["Encoding:", @encoding])
      s += (headline % ["Creator:", @creator.escape_html]) if @creator
      s += "</table></td></tr></table>\n"

      if @description and @description !~ /\A\s*</m
        s += "<br/>\n"
      end
      s += "#{@description}" if @description

      @items.each do |i|
        s += "\n<hr/><!-- *********************************** -->\n"
        s += i.to_html(localtime)
      end
      s += "\n</body></html>\n"
      s
    end
  end

  class FeedItem
    def to_html_with_headers(localtime = true)
      s = <<-EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body style="margin:0">
  EOF
      s += to_html(localtime)
      s += "\n</body>\n</html>"
      s
    end

    def to_html(localtime = true)
      s = "<iframe src=\"#{@link}\" style=\"border: 0; width: 100%; height: 100%\"></iframe>\n"
    end
  end
end
