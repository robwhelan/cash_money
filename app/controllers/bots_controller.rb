class BotsController < ApplicationController

  def api_ai_webhook
    
    action = params[:result][:action]

    case action
    when "record_transaction"
      amount = params[:result][:parameters][:number]
      subcategory = params[:result][:parameters]["category-original"]
      category = params[:result][:parameters]["category"]

      transaction = Transaction.create(
        amount: amount,
        subcategory: subcategory,
        category: category
        )
      
      speech = "I recorded $" + transaction.amount.to_s + " spent on " + transaction.subcategory + " under " + transaction.category + "."
      display_text = speech
    when "get_finance_info"
      subcategory = params[:result][:parameters][:category]
      date_period = params[:result][:parameters]["date-period"]
      
      if Transaction.where(subcategory: subcategory).nil?
        speech = "You haven't spent anything in " + subcategory + "."
      else
        category = Transaction.where(subcategory: subcategory).last.category
        subcategory_amount = Transaction.where(subcategory: subcategory).sum(:amount)
        category_amount = Transaction.where(category: category).sum(:amount)
        speech = "You've spent $" + subcategory_amount.to_s + " on " + subcategory + " and " + category_amount.to_s + " on " + category + "."
      end
      
      display_text = speech
    end
    
    my_hash = {
      speech: speech,
      displayText: display_text,
      data: {},
      contextOut: [],
      source: "Rails App"
    }
    
    render json: my_hash.to_json
  end

end
