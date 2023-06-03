select * from Cenus_analog.dbo.Data1;

select * from Cenus_analog.dbo.Data2;

-- Number of rows in our dataset.

select count(*) from Cenus_analog..Data1;
select count(*) from Cenus_analog..Data2;

-- dataset for jharkhand and bihar

select * from Cenus_analog..Data1 where state in ('Jharkhand','Bihar');

--Total Population of Indian

select sum(population) population from Cenus_analog..Data2;

--Average growth of the states (Grouping by states)

select avg(growth)*100 as average from Cenus_analog..Data1;
select state,avg(growth)*100 as average from Cenus_analog..Data1 group by state;

--Average sex ratio of the states (In descending Order)

select state,round(avg(sex_ratio),0) as avg_sex_ratio from Cenus_analog..Data1 group by state order by avg_sex_ratio desc;

--Average literacy rate of the states (Greater than 90)

select state,round(avg(literacy),0) as avg_literacy from Cenus_analog..Data1
group by state having round(avg(literacy),0) > 90 order by avg_literacy desc;

-- Top 5 states showing highest growth ratio

select top 5 state,avg(growth) as avg_growth from Cenus_analog..Data1 group by state order by avg_growth desc;
select state,avg(growth) as avg_growth from Cenus_analog..Data1 group by state order by avg_growth desc limit 3;


-- Bottom 5 states showing lowest growth ratio

select top 5 state,avg(growth) as avg_growth from Cenus_analog..Data1 group by state order by avg_growth asc;

--Top and Bottom sex_ratio of the states (Union Operator)

select * from (
select top 5 state,avg(sex_ratio)*100 as avg_sex_ratio from Cenus_analog..Data1 group by state order by avg_sex_ratio desc)a
union
select * from (
select top 5 state,avg(sex_ratio)*100 as avg_sex_ratio from Cenus_analog..Data1 group by state order by avg_sex_ratio asc)b;

-- States starting with letter a or ending with h

select distinct state from Cenus_analog..Data2 where lower(state) like 'a%' or lower(state) like '%h';

-- States starting with letter a and ending with h

select distinct state from Cenus_analog..Data2 where lower(state) like 'a%' and lower(state) like '%h'

-- Joining two tables
create table Data3(state nvarchar(255),district nvarchar(255),sex_ratio float,population float);
insert into Data3
select a.state, a.district, a.sex_ratio, b.population from Cenus_analog..Data1 a inner join Cenus_analog..Data2 b on a.district=b.district;

select * from Data3;

-- Using WHERE Clause

select distinct state ,sex_ratio from Data3 where sex_ratio > 845;
select distinct state , sex_ratio from Data3 where sex_ratio between 800 and 940 order by sex_ratio;

-- Min and Max growth and sex_ratio of the states

select distinct state, max(sex_ratio) as max from Data3 group by state order by max(sex_ratio);
select distinct state, max(growth) as max from Data1 group by state order by max(growth);

delete from data1 where state='NULL';
delete from data1 where state='State';

-- Using Wildcard Funtion

select district from data3 where district like '[abs]%[rn]';
select district from data3 where district like '_i%'

-- Creating stored procedure
create procedure selectall as select * from data1 go;
exec selectall;

