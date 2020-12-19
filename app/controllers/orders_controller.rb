class OrdersController < ApplicationController
    def search
    end  
    
    def index
     @orders = Order.all.order("created_at DESC").paginate(page: params[:page], per_page: 5)
     @search = params["search"]
      if @search.present?
       @name = @search["name"]
       @producttype = @search['producttype']
       @ordertype = @search['ordertype']
       @quantity = @search['quantity']
       @buysell = @search["buysell"]
       @platform = @search['platform']
       @client = @search['client']
       @finished = @search["finished"]
       @in_account = @search['in_account']
       @time = @search['time']
       @startdate = @search['startdate']
       @enddate = @search['enddate'] == "" ? Date.today + 1 : @search['enddate']
       if @name != ""
        @orders = @orders.where('lower(name) = ?', @name.downcase)
       end
       if @producttype != ""
        @orders = @orders.where('lower(producttype) = ?', @producttype.downcase)
       end
       if @quantity.to_f > 1
        @orders = @orders.where(quantity: @quantity)
       end 
       if @ordertype != ""
        @orders = @orders.where(ordertype: @ordertype)
       end 
       if @buysell != ""
        @orders = @orders.where(buysell: @buysell)
       end
       if @platform.to_f > 1
        @orders = @orders.where(platform: @platform)
       end
       if @client.to_f > 1
        @orders = @orders.where(client: @client)
       end
       if @finished != ""
        @orders = @orders.where(finished: @finished == "Yes" ? true : false)
       end
       if @in_account != ""
        @orders = @orders.where(in_account: @in_account == "Yes" ? true : false)
       end
       if @time != ""
        @orders = @orders.where(time: @time)
       end
       if @startdate != ""
        @orders = @orders.where(created_at: @startdate.to_time..@enddate)
       end  
      end
    end

    def new
        @order = Order.new
    end

    def create
      @order = Order.new(order_params)  

      if @order.save
        redirect_to @order
      else
          render 'new'  
      end  
    end

    def show
      @order = Order.find(params[:id])  

      respond_to do |format|
        format.html
        format.pdf do
            render pdf: "Order No. #{@order.id}",
            page_size: 'A4',
            template: "orders/orderpdf.html.erb",
            layout: "pdf.html",
            orientation: "Landscape",
            lowquality: true,
            zoom: 1,
            dpi: 75
        end
     end
    end

    def update
      @order = Order.find(params[:id])

      if @order.update(order_params)
        redirect_to @order
      else
          render 'edit'  
      end
    end

    def edit
      @order = Order.find(params[:id])  
    end

    def destroy
      @order = Order.find(params[:id])
      
      @order.destroy
      redirect_to orders_path
    end

    def searchpdf
    end  

    def orderpdf
      @orders = Order.all.order("created_at DESC")

      @search = params["search"]
      if @search.present?
       @name = @search["name"]
       @producttype = @search['producttype']
       @ordertype = @search['ordertype']
       @quantity = @search['quantity']
       @buysell = @search["buysell"]
       @platform = @search['platform']
       @client = @search['client']
       @finished = @search["finished"]
       @in_account = @search['in_account']
       @time = @search['time']
       @startdate = @search['startdate']
       @enddate = @search['enddate'] == "" ? Date.today + 1 : @search['enddate']
       if @name != ""
        @orders = @orders.where('lower(name) = ?', @name.downcase)
       end
       if @producttype != ""
        @orders = @orders.where("lower(producttype) = ?", @producttype.downcase)
       end
       if @quantity.to_f > 1
        @orders = @orders.where(quantity: @quantity)
       end 
       if @ordertype != ""
        @orders = @orders.where(ordertype: @ordertype)
       end 
       if @buysell != ""
        @orders = @orders.where(buysell: @buysell)
       end
       if @platform.to_f > 1
        @orders = @orders.where(platform: @platform)
       end
       if @client.to_f > 1
        @orders = @orders.where(client: @client)
       end
       if @finished != ""
        @orders = @orders.where(finished: @finished == "Yes" ? true : false)
       end
       if @in_account != ""
        @orders = @orders.where(in_account: @in_account == "Yes" ? true : false)
       end
       if @time != ""
        @orders = @orders.where(time: @time)
       end
       if @startdate != ""
        @orders = @orders.where(created_at: @startdate.to_time..@enddate)
       end  
      end

      respond_to do |format|
        format.html
        format.pdf do
            render pdf: "Orders",
            page_size: 'A4',
            template: "orders/orderpdf.html.erb",
            layout: "pdf.html",
            orientation: "Landscape",
            lowquality: true,
            zoom: 1,
            dpi: 75
        end
     end
    end  

    private

    def order_params
        params.require(:order).permit(:name,:producttype,:quantity,:buysell,:platform,:client,:time,:finished,:ordertype,:in_account)
      end
end
