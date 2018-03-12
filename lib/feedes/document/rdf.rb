module Feedes
  module Document
    class Rdf < Base
      def found_chars(path, name, str)
        if path =~ %r{rdf:RDF\/item\/#{name}}
          @result[name] = convert_chars(name, str)
        elsif path =~ %r{rdf:RDF\/channel\/#{name}}

          case name
          when :title, :link, :description
            @feed_meta[name] = str
          else
          end
        end
      end

      def finish_element(path, _name)
        return unless path == '//rdf:RDF/item'
        return if @result.empty?

        @items.push(@result)
        @result = {}
      end

      private

      def convert_chars(name, str)
        case name
        when :title, :link, :description, :"dc:creator"
          str
        when :"dc:date"
          DateTime.strptime(str, '%Y-%m-%dT%H:%M:%S%z')
        when :"dc:subject"
          (@result[name]) ? @result[name].push(str) : [str]
        when :"hatena:bookmarkcount"
          str.to_i
        else
          nil
        end
      end
    end
  end
end
