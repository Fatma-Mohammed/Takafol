class CheckoutController < ApplicationController
    def create
        @case = Case.find(params[:id])
        @amount = (params[:amount].to_i * 100)

        if @case.nil?
            redirect_to root_path
            return
        end

        @session =Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: [{
                name: @case.id,
                amount: @amount,
                currency: 'egp',
                quantity: 1,
            }],
            success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}" ,
            cancel_url:  checkout_cancel_url
        )

        respond_to do |format|
          format.html { render(:text => "not implemented") }
          format.js #render create.js.erb
        end
    end


    def success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
        @id=@session["display_items"][0]["custom"]["name"]
        @case = Case.find(@id)
        @amount_received = @payment_intent["amount_received"]
        if @case.amount_obtained.nil?
            @total = @amount_received /100
        else
            @total = @case.amount_obtained + @amount_received / 100
        end
        @case.update(amount_obtained: @total )
    end


    def cancel

    end
end
