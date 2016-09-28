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
      
      speech = "I recorded $" + transaction.amount + " spent on " + transaction.subcategory + "."
      display_text = speech
    when "get_finance_info"
      puts "get finance info"
      speech = "get yer finance info"
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
