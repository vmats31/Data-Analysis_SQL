#TASK 1
#The data appears to be from retail super store having information about Customers, Products, Orders, Shipping 
#and the Entire market.
#Customer information is included in the cust_dimen table including information about the cient/customer name, 
#region of office, type of business and a unique ID.
#Order information is collected in the orders_dimen table with a unique ID, order date, priority if order 
#and another id indicating a serial no. of order
#prod_dimen contains all information about the products 
#shipping_dimen contains all the shippimg information of the products  
#market_fact is essentially the primary key to decipher all the remaining tables containing unique order ids 
#so that orders and shipping information may be accessed. 
#There are prod ids and cust ids as well in the market_fact to uniquely decipher products and
#customers respectively.

#TASK 2
#A
select sum(sales) as 'total_sales', avg(sales) as 'avg_sales'
from market_fact;
#B
select Region, count(region) as no_of_customers 
from cust_dimen
group by region;
#C
select Region, count(Region)
from cust_dimen
group by Region
order by count(*) desc;

#D
select order_quantity as 'no_of_products_sold', prod_id
from market_fact 
group by prod_id
order by order_quantity desc;

#E
select cd.Customer_Name,  mf.Order_Quantity as'no_of_tables purchased'
from market_fact mf inner join cust_dimen cd on mf.cust_id=cd.cust_id
     inner join prod_dimen pd on mf.prod_id=pd.prod_id
where cd.Region='ATLANTIC' and pd.Product_Sub_Category='TABLES';


#TASK 3
#A 
select pd.Product_Category, sum(mf.Profit) as 'profits'
from market_fact mf inner join prod_dimen pd on mf.prod_id=pd.prod_id
group by pd.Product_Category
order by count(*) desc;

select pd.Product_Category, pd.Product_Sub_Category, sum(mf.Profit) as 'profits'
from market_fact mf inner join prod_dimen pd on mf.prod_id=pd.prod_id
group by pd.Product_Sub_Category
order by pd.Product_Category;

select cd.Region, count(pd.Product_Sub_Category) as 'no_of_shipments', sum(mf.Profit) as'Profit_in_each_region'
from market_fact mf inner join shipping_dimen sd on mf.ship_id=sd.ship_id
  inner join prod_dimen pd on mf.prod_id=pd.prod_id
  inner join cust_dimen cd on mf.cust_id=cd.Cust_id
group by cd.Region
order by count(*) desc;