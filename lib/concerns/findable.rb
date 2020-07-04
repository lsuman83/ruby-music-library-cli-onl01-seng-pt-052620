require 'pry'
module Concerns
    module Findable
        module ClassMethods

            def find_by_name(name)

                self.all.find {|n| n.name == name}

            end

            def find_or_create_by_name(name)

                self.find_by_name(name) || self.create(name)

            end

        end

    end

end
        
