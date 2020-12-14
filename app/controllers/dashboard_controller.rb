class DashboardController < ApplicationController
   def home
      @buystotal = 0
      @buysquantity = 0
      @buysinkg = 0
      @buysingram = 0
      @buysintt = 0
      @sellstotal = 0
      @sellsquantity = 0
      @sellsinkg = 0
      @sellsingram = 0
      @sellsintt = 0
      @commissionprofit = 0
      @uncompletedbuysquantity = 0
      @uncompletedsellsquantity = 0
      @uncompletedbuysinkg = 0
      @uncompletedbuysingram = 0
      @uncompletedbuysintt = 0
      @uncompletedsellsinkg = 0
      @uncompletedsellsingram = 0
      @uncompletedsellsintt = 0
      @uncompletedorderscommission = 0
      @orders = Order.all.order("created_at DESC")
      @orders.each do |order|
        if order.buysell == "Buy" && order.finished == true
         @buystotal = @buystotal + (order.platform * order.quantity)
         @buysquantity = @buysquantity + order.quantity
         if order.ordertype == "Kg"
          @buysinkg = @buysinkg + ((order.quantity > 320 ? order.quantity / 31.1 : order.quantity / 32).round(2))
         end 
         if order.ordertype == "Gram"
          @buysingram = @buysingram + ((order.quantity > 312.5 ? order.quantity * 31.1 : order.quantity * 32 ).round(2))
         end 
         if order.ordertype == "TT Bar"
          @buysintt = @buysintt + ((order.quantity / 3.79).round(2))
         end 
        end
        if order.buysell == "Sell" && order.finished == true
          @sellstotal = @sellstotal + (order.platform * order.quantity)
          @sellsquantity = @sellsquantity + order.quantity
          if order.ordertype == "Kg"
            @sellsinkg = @sellsinkg + ((order.quantity > 320 ? order.quantity / 31.1 : order.quantity / 32).round(2))
          end
          if order.ordertype == "Gram"
            @sellsingram = @sellsingram + ((order.quantity > 312.5 ? order.quantity * 31.1 : order.quantity * 32 ).round(2))
          end
          if order.ordertype == "TT Bar"
            @sellsintt = @sellsintt + ((order.quantity / 3.79).round(2))
          end      
        end 
        if order.finished == true
          buycommission = 0
          sellcommission = 0
          if order.buysell == "Buy"
           buycommission = buycommission + ((order.client - order.platform) * order.quantity)
          end
          if order.buysell == "Sell"
           sellcommission = sellcommission + ((order.platform - order.client) * order.quantity)
          end
          @commissionprofit = @commissionprofit + buycommission + sellcommission 
        end
       if order.finished == false
        uncompletedbuyscommission = 0
        uncompletedsellscommission = 0
        if order.buysell == "Buy"
         @uncompletedbuysquantity = @uncompletedbuysquantity + (order.quantity)
         uncompletedbuyscommission = uncompletedbuyscommission + ((order.client- order.platform) * order.quantity)
         if order.ordertype == "Kg"
          @uncompletedbuysinkg = @uncompletedbuysinkg + ((order.quantity > 320 ? order.quantity / 31.1 : order.quantity / 32).round(2))
         end
         if order.ordertype == "Gram"
          @uncompletedbuysingram = @uncompletedbuysingram + ((order.quantity > 312.5 ? order.quantity * 31.1 : order.quantity * 32 ).round(2))
         end 
         if order.ordertype == "TT Bar"
          @uncompletedbuysintt = @uncompletedbuysintt + ((order.quantity / 3.79).round(2))
        end
        
       end
       
       if order.buysell == "Sell"
        @uncompletedsellsquantity = @uncompletedsellsquantity + (order.quantity)
        uncompletedsellscommission = uncompletedsellscommission + ((order.platform - order.client) * order.quantity)
        if order.ordertype == "Kg"
          @uncompletedsellsinkg = @uncompletedsellsinkg + ((order.quantity > 320 ? order.quantity / 31.1 : order.quantity / 32).round(2))
         end
         if order.ordertype == "Gram"
          @uncompletedsellsingram = @uncompletedsellsingram + ((order.quantity > 312.5 ? order.quantity * 31.1 : order.quantity * 32 ).round(2))
         end 
         if order.ordertype == "TT Bar"
          @uncompletedsellsintt = @uncompletedsellsintt + ((order.quantity / 3.79).round(2))
        end
       end 
       @uncompletedorderscommission = @uncompletedorderscommission + uncompletedsellscommission + uncompletedbuyscommission
      end   
   end 
end
end
