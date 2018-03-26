class FutureValidator < ActiveModel::EachValidator
  

  
  def validate_each(record, attribute, value)
    if record[attribute] == nil
      record.errors[attribute] << (options[:message] || "must be a valid datetime")
    
    else
      if record[attribute] < Time.now - 5.hours
      record.errors[attribute] << (options[:message] || "can't be in the past!")
     
      end
    end
    
  end
  
  
end