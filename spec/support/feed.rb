# frozen_string_literal: true

def feed_xml(name)
  path = Pathname.new(__dir__).join('contents', name)
  File.open(path, 'r').readlines.join("\n")
end
