# frozen_string_literal: true

require_relative './base.rb'

module Feedes
  module Document
    class Guess < Base
      attr_reader :type

      def initialize
        super
        @type = :unknown
      end

      def finish_element(path, _name)
        case path
        when '//rdf:RDF' then @type = :rdf
        when '//rss'     then @type = :rss
        when '//feed'    then @type = :atom
        end
      end
    end
  end
end
