function[data_train,data_test]=data_preprocessing(data,olddate_begin,olddate_end,newdate,week_or_month,tongbi_index,select_index)
for index=1:7
    switch string(cell2mat(data(index,1)))
        case '频度'
            freq_index=index;
        case '指标名称'
            name_index=index;
    end
end
freqs=data(freq_index,2:end);
names=data(name_index,2:end);
data2=NaNts(data);
switch week_or_month
    case '周'
        [data3,dates]=day2week3(data2,freqs);
         if ~isempty(tongbi_index)
            data3=tongbi2(data3,tongbi_index);
            dates=dates(1:end-48);
        end
    case '月'
        [data3,dates]=day2month(data2);
        if ~isempty(tongbi_index)
            data3=tongbi(data3,tongbi_index);
            dates=dates(1:end-12);
        end
end

%%
for index=1:max(size(dates))
    switch string(dates(index))
        case olddate_begin
            olddate_begin_index=index;
        case olddate_end
            olddate_end_index=index;
        case newdate
            newdate_index=index;
    end
end
freqs=freqs(select_index);
names=names(select_index);
y=data3(:,select_index);
if week_or_month=='周'
    %%%%%%%%%%%%%%%%%
    y=roll_mean2(y,freqs);
    %%%%%%%%%%%%%%%%%%
    freqs_T=(cell2mat(freqs)=='月')*3+1;
else
    freqs_T=ones(size(freqs));
end

%%%

data_train.y=y(olddate_begin_index:-1:olddate_end_index,:);
data_train.dates=dates(olddate_begin_index:-1:olddate_end_index,:);
data_train.names=names;
data_train.freqs=freqs_T;
data_test.y=y(olddate_end_index-1:-1:newdate_index,:);
data_test.dates=dates(olddate_end_index-1:-1:newdate_index,:);
data_test.names=names;
data_test.freqs=freqs_T;

end



function[newdata]=NaNts(data)
newdata=data;
for i=2:size(data,2)
    for j=8:size(data,1)
        if isempty(cell2mat(data(j,i)))||isnan(cell2mat(data(j,i)))...
                ||(cell2mat(data(j,i))=='-')
            newdata(j,i)={NaN};
        end
    end
end
end

function[newdata,weeks]=day2week3(data,freqs)
time_end=char(string(data(8,1)));
time_begin=char(string(data(end,1)));
months=12*(eval(time_end(1:4))-eval(time_begin(1:4)))...
+eval(time_end(6:7))-eval(time_begin(6:7))+1;
newdata=zeros(4*months,size(data,2)-1)*NaN;
weeks=[];
for i=1:4
    dates=datetime(eval(time_end(1:4)),eval(time_end(6:7)),35-7*i):-calmonths(1):...
    datetime(eval(time_begin(1:4)),eval(time_begin(6:7)),35-7*i);
    weeks=[weeks; dates];
end
weeks=reshape(weeks,[4*months,1]);



begins=size(data,1);
ends=begins;
for i=1:months
    enddate=char(string(data(ends,1)));
    if i<months
        thedate=weeks(end-4*i)-caldays(7);
    else
        thedate=weeks(end)+caldays(3);
    end

    while enddate<=string(thedate)
        ends=ends-1;
        enddate=char(string(data(ends,1)));
        if strlength(enddate)<7
            break
        end
    end
    for index=2:size(data,2)
        freq=cell2mat(freqs(index-1));
        if freq=='月'
            dataneed=cell2mat(data(ends+1:begins,index));
            if sum(isnan(dataneed))==size(dataneed,1)
                 newdata(end-4*i+1,index-1)=NaN;
            else           
                 newdata(end-4*i+1,index-1)=mean(dataneed,"omitnan");
            end
        end
    end
    begins=ends;
end


begins=size(data,1);
ends=begins;
for i=1:4*months
    enddate=char(string(data(ends,1)));
    thedate=weeks(end-i+1);
    while enddate<=string(thedate)
        ends=ends-1;
        enddate=char(string(data(ends,1)));
        if strlength(enddate)<7
            break
        end
    end
    for index=2:size(data,2)
        freq=cell2mat(freqs(index-1));
        if ~(freq=='月')
        dataneed=cell2mat(data(ends+1:begins,index));
        if sum(isnan(dataneed))==size(dataneed,1)
            newdata(end-i+1,index-1)=NaN;
        else           
            newdata(end-i+1,index-1)=mean(dataneed,"omitnan");
        end
        end
    
    end
    begins=ends;
end
end

function[newdata,dates]=day2month(data)
time_end=char(string(data(8,1)));
time_begin=char(string(data(end,1)));
months=12*(eval(time_end(1:4))-eval(time_begin(1:4)))...
+eval(time_end(6:7))-eval(time_begin(6:7))+1;
newdata=zeros(months,size(data,2)-1);
begins=size(data,1);
ends=begins;
dates=datetime(eval(time_end(1:4)),eval(time_end(6:7)),28):-calmonths(1):...
datetime(eval(time_begin(1:4)),eval(time_begin(6:7)),28);
dates=dates';
for i=1:size(newdata,1)
   mons=i-1+eval(time_begin(6:7));
   year=eval(time_begin(1:4))+ceil(mons/12)-1;
   month=mons-(ceil(mons/12)-1)*12;
   thedate=[num2str(year) '-' num2str(floor(month/10)) num2str(mod(month,10)) ];
   %disp(newdata(months-i+1,1))
   %newdata(months-i+1,1)=dates(i);
   %disp(newdata(months-i+1,1))
   %disp(string(thedate))
   %disp(newdata(end-i+1,1))
   %dates=[thedate ;dates];
   enddate=char(string(data(ends,1)));
   %disp(thedate)
   %while strcmp(enddate(1:7),thedate)
   while enddate(1:7)==string(thedate)
       ends=ends-1;
       enddate=char(string(data(ends,1)));
       if strlength(enddate)<7
           break
       end
   end
   %disp(data(ends+1:begins,2:end))
   for j=2:size(data,2)
       dataneed=cell2mat(data(ends+1:begins,j));
       if sum(isnan(dataneed))==size(dataneed,1)
           newdata(end-i+1,j-1)=NaN;
       else           
           %disp(newdata(months-i+1,j))
           newdata(end-i+1,j-1)=mean(dataneed,"omitnan");
           %disp(newdata(months-i+1,j))
       end
   end
   begins=ends;
end


end

function[newdata]=tongbi(data,select)
newdata=data(1:end-12,:);
for j=select
    newdata(:,j)=(data(1:end-12,j)-data(13:end,j))./data(13:end,j);
end

end

function[newdata]=tongbi2(data,select)
newdata=data(1:end-48,:);
for j=select
    newdata(:,j)=(data(1:end-48,j)-data(49:end,j))./data(49:end,j);
end
end

function[newdata]=roll_mean(data,freq)
newdata=data;
for i=1:size(freq,2)
    if ~(cell2mat(freq(i))=='月')%%%可以改
        newdata(:,i)=movmean(data(:,i),[0 3],"omitnan");
    end
end
end

function[newdata]=roll_mean2(data,freq)
newdata=data;
for i=1:size(freq,2)

    newdata(:,i)=movmean(data(:,i),[0 3],"omitnan");

end
end


