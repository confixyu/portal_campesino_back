module Api
	class ProductsController < ApiController
		skip_before_action :authorized, only: [:index]

		def index
			render json: { data: Product.all }
		end

		def list_by_user
			render json: { data: @user.products }
		end

		def create
			product = @user.products.create(product_params)
			if product.save
				render json: { data: product }, status: :created
			else
				render json: { error: product.errors }, status: 422
			end
		end
		
		private

		def product_params
			params.require(:product).permit(:name, :description, :price, :stock, 
										:img_url, :farm, :price_per_pack, :sku, 
										:freshness, :category, :buy_by, :delivery, 
										:delivery_Area)
		end
	end
end
