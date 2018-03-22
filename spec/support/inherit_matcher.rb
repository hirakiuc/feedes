RSpec::Matchers.define :inherit_from do |superclass|
  match do |klass|
    klass.class.ancestors.include? superclass
  end

  failure_message do |klass|
    "expected #{klass.class.name} to inherit from #{superclass}"
  end

  failure_message_when_negated do |klass|
    "expected #{klass.class.name} not to inherit from #{superclass}"
  end
end
