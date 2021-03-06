module Closeio
  class PaginatedList < ::Array
    attr_reader :total, :pages, :per_page, :page
    def initialize(results)
      @total = results['total']
      @pages = results['pages']
      @per_page = results['per_page']
      @page = results['page']

      result_key, result_class = 
        if results.has_key?('shots')
          ['shots', Closeio::Shot]
        elsif results.has_key?('lead')
          ['leads', Closeio::Lead]
        else
          ['comments', Closeio::Comment]
        end

      super((results[result_key] || []).map { |attrs| result_class.new attrs })
    end

    def inspect
      ivar_str = instance_variables.map {|iv| "#{iv}=#{instance_variable_get(iv).inspect}"}.join(", ")
      "#<#{self.class.inspect} #{ivar_str}, @contents=#{super}>"
    end
  end
end
