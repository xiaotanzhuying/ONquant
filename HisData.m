function HisDB = HisData(DB,windcode,Options)
I = DB.CurrentK;
HisDB = DB;
HisDB.Benchmark = HisDB.Benchmark(1:I,:);
HisDB.Times = HisDB.Times(1:I,:);
HisDB.TimesStr = HisDB.TimesStr(1:I,:);
for i=1:max(size(windcode))
    stock = windcode{i};
    Data=getfield(HisDB,[stock(8:9) stock(1:6)]);
    Data.Times = Data.Times(1:I,:);
    Data.TimesStr = Data.TimesStr(1:I,:);
    Data.Sec_status = Data.Sec_status(1:I,:);
    Data.Trade_status = Data.Trade_status(1:I,:);
    Data.Pct_chg = Data.Pct_chg(1:I,:);
    Data.Open = Data.Open(1:I,:);
    Data.High = Data.High(1:I,:);
    Data.Low = Data.Low(1:I,:);
    Data.Close = Data.Close(1:I,:);
    Data.Volume = Data.Volume(1:I,:);
    HisDB=setfield(HisDB,[windcode{i}(8:9) windcode{i}(1:6)],Data);
end