module Api
	class PurchasesController < ApiController
		skip_before_action :authorized
		
		def index
			render json: { data: Purchase.all }
		end

		def create
			purchase = Purchase.create(purchase_params)
			product = Product.find(purchase_params[:product_id])
			
			sub_total = product.price * purchase_params[:quantity]
			purchase.sub_total = sub_total
			new_quantity = product.quantity - purchase_params[:quantity]

			purchase.total_to_pay = sub_total + (purchase_params[:transport_cost] ? purchase_params[:transport_cost] : 0)

			if new_quantity > 0
				if purchase.save and product.update(quantity: new_quantity)
					render json: { data: purchase }, status: :created
				else
					render json: { error: purchase.errors }, status: 422
				end
			else
				render json: { error: "Quantity is not available" }, status: 422
			end
		end
		
		private

		def purchase_params
			params.require(:purchase).permit(:product_id, :quantity, :client_name, :phone, :address, :state, :city, :transport_cost)
		end
	end
end
