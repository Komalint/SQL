create proc udp_getBike_data(
@id int)
as 
begin
select * from Bikeshop where Id =@id;
end
