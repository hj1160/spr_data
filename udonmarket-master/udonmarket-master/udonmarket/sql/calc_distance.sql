create or replace
function calc_distance
(
    plat1 number,
    plon1 number,
    plat2 number,
    plon2 number
)
return number
is
cspherrad constant number := 6367; 

a        number;
vlat     number;
vlat1rad number;
vlat2rad number;
vlon     number;
vlon1rad number;
vlon2rad number;
begin
  vlat1rad := plat1 * 0.017453293;
  vlat2rad := plat2 * 0.017453293;
  vlon1rad := plon1 * 0.017453293;
  vlon2rad := plon2 * 0.017453293;

  vlon := vlon2rad - vlon1rad;
  vlat := vlat2rad - vlat1rad;

  a := power(sin(vlat/2),2) + cos(vlat1rad) * cos(vlat2rad) *
  power(sin(vlon/2),2);

  return round(cspherrad * 2 * atan2(sqrt(a), sqrt(1-a)),1);
exception
  when others then
    return 999;
end calc_distance;

create or replace trigger trig_like_this after insert on like_this for each row begin update board set like_this = like_this + 1 where b_code = :new.b_code; end;