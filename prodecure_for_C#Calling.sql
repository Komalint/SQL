create proc udp_getBike_data(
@id int)
as 
begin
select * from Bikeshop where Id =@id;
end


-- ============================ 07-10-2026 ========================================

CREATE TABLE Bikeshop
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50),
    Price DECIMAL(10,2)
);

-- get all details
create proc udp_getAllBike_data
as 
begin
select [Id]
       ,[Name]
	   ,[Price]
from Bikeshop ;
end


-- insert into bikeshop
alter proc udp_insertBike_data(
	@bName varchar(50), 
	@bPrice decimal(10,2),
	@msg varchar(100) out
)
as 
begin
	insert into Bikeshop  
	values(@bName,@bPrice);
	if(@@ROWCOUNT >0)
		set @msg = 'Inserted data successfully!'
	else 
		set @msg ='Data insertion failed!'
end


-- update bikeshop details
alter proc udp_updatetBike_data(
	@id int,
	@bName varchar(50), 
	@bPrice decimal(10,2),
	@msg varchar(100) out
)
as 
begin
	if @bName != ''
	update Bikeshop 
	set Name=@bName where Id =@id;
	if @bPrice != 0
	update Bikeshop 
	set  Price = @bPrice where Id =@id;

	if(@@ROWCOUNT >0)
	set @msg = 'Updated ' + CAST(@id as varchar(10)) + 'details successfully!'
	else 
	set @msg ='OOPs,  Updation of details failed!'
end


-- deleting row from bikeshop where id matches
create proc udp_deletedBikeDataById (
@id int, 
@msg varchar(50) out)
as
begin 
delete from Bikeshop where Id =@id
if(@@ROWCOUNT >0)
set @msg = 'Bike with Id : '+ cast(@id as varchar(5)) +' has been deleted sucessfully'
else
set @msg = 'Bike with Id : '+ cast(@id as varchar(5)) +' has not been deleted. Failed'

end