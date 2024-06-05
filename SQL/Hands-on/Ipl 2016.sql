ALTER TABLE Wicket_Taken
ADD CONSTRAINT fk2_Match_id
FOREIGN KEY (Match_id)
REFERENCES Match(Match_id);


ALTER TABLE Season
ADD CONSTRAINT Purple_Cap
FOREIGN KEY (Purple_Cap)
REFERENCES Player(Player_id);




ALTER TABLE Season
ALTER COLUMN Purple_Cap INT;

--ALTER TABLE Player
--ADD CONSTRAINT PK_Player_id PRIMARY KEY (Player_id);

--ans 1

create table #Runs_per_over(
    Match_id int,
    Over_id tinyint,
    innings_No tinyint,
    Runs_per_over tinyint
);


;WITH cte1 AS (
    SELECT Bs.Match_id, Bs.Over_id, Bs.Ball_id, Bs.Runs_Scored, Bs.innings_No
    FROM Batsman_Scored AS Bs
    JOIN Extra_Runs AS Er ON Bs.Match_Id = Er.Match_Id
    WHERE Er.Extra_Type_Id IN (1, 3)
)
INSERT INTO #Runs_per_over (Match_id, Over_id, innings_No, Runs_per_over)
SELECT Match_id, Over_id, innings_No, SUM(runs_scored) AS Runs_per_over
FROM cte1 
GROUP BY Match_id, Over_id, innings_No
HAVING SUM(runs_scored) = 0;

--select * from #Runs_per_over;

--with cte2 
--as
 --( 
   --select rpo.Match_Id,rpo.Over_Id,rpo.innings_No,rpo.Runs_per_over from #Runs_per_over as rpo
   --join Match as M on rpo.Match_id=M.Match_Id
   --where year(M.Match_date)='2016'
-)
--select count(*) from cte2

create table #Maiden_overs_in_2016(
    Match_id int,
    Over_id tinyint,
    innings_No tinyint,
    Runs_per_over tinyint
);

INSERT INTO #Maiden_overs_in_2016(Match_id, Over_id, innings_No, Runs_per_over)
select rpo.Match_Id,rpo.Over_Id,rpo.innings_No,rpo.Runs_per_over from #Runs_per_over as rpo
   join Match as M on rpo.Match_id=M.Match_Id
   where year(M.Match_date)='2016'

--select * from #Maiden_overs_in_2016;



-- select  * from Ball_by_Ball

create table #Count_of_maiden(
   Player_Id int,No_of_maiden_overs int
);

 with cte3
 as 
 (
  select distinct bbb.Match_id,bbb.over_id,bbb.Innings_no,bbb.Bowler from Ball_by_Ball as bbb
  join #Maiden_overs_in_2016 as Mo on bbb.Match_id=Mo.Match_Id
  where mo.Over_id =bbb.Over_Id and mo.innings_No=bbb.Innings_No
 )


INSERT INTO #Count_of_maiden (Player_Id,No_of_maiden_overs)
select Bowler, Count(1) as No_of_MAiden_Overs from cte3
group by Bowler


select p.Player_name,com.No_of_maiden_overs from Player as p
join #Count_of_maiden as com on p.Player_Id=com.Player_Id
order by com.No_of_maiden_overs desc ;


--q2
select  * from Ball_by_Ball
select * from Batsman_Scored

select * from match 
select *from Player

/*select Bs.Match_id,sum(Bs.Runs_Scored),bbb.Striker from Batsman_Scored as Bs 
join Ball_by_Ball as bbb on Bs.Match_id=bbb.Match_id
where Bs.over_id=bbb.Over_Id and Bs.ball_id=bbb.Ball_Id
group by Bs.Match_id,bbb.Striker

select bbb.Striker as Player_id,sum(Bs.Runs_Scored) as Run_scored_by_Batsmane  from Batsman_Scored as Bs 
join Ball_by_Ball as bbb on Bs.Match_id=bbb.Match_id
join Match as M on Bs.Match_Id=M.Match_Id
where Bs.over_id=bbb.Over_Id and Bs.ball_id=bbb.Ball_Id and year(M.Match_Date)='2016'
group by bbb.Striker;*/

--ans
;with cte4
as (
select p.Player_Name,sum(Bs.Runs_Scored) as Run_scored_by_Batsman  from Batsman_Scored as Bs 
join Ball_by_Ball as bbb on Bs.Match_id=bbb.Match_id
join Match as M on Bs.Match_Id=M.Match_Id
join Player as p on bbb.Striker=p.Player_Id
where Bs.over_id=bbb.Over_Id and Bs.ball_id=bbb.Ball_Id and year(M.Match_Date)='2016'
group by bbb.Striker,p.Player_Name
)

