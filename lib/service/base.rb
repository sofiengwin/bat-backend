module Service
  class Base
    include ActiveModel::Validations

    # null-ish
    NOT_SET = Object.new
    def NOT_SET.try!(*_)
      NOT_SET
    end

    def self.perform(*args, **params)
      klass = params.any? ? new(*args, **params) : new(*args)
      klass.instrument
    end

    def self.fields
      @fields ||= []
    end

    def self.field(name, optional: false, **validations)
      attr_reader name
      fields << name.to_sym
    
      if optional && validations.any?
        validates name, validations.merge(unless: -> { send(name).eql?(NOT_SET) })
      elsif validations.any?
        validates name, validations
      end
    end

    def instrument
      name = self.class.name.underscore

      STATSD.time('service.perform', tags: ["environment:#{Rails.env}", "service:#{name}"]) do
        perform
      end
    end

    private def changeset
      self.class.fields.reduce({}) do |h, f|
        send(f).eql?(NOT_SET) ? h : h.merge(f => send(f))
      end
    end
  end
end