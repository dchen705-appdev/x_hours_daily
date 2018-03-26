class DateTimeValidator < ActiveModel::EachValidator
  
 def validate_each(record, attribute, value)
 
    if ((DateTime.parse(value) rescue ArgumentError) == ArgumentError)  
      record.errors[attribute] << (options[:message] || "must be a valid datetime")
    end
 end
  
end

  
