function Asset = Order(DB,Asset,stock,volume,type,Options)
I = DB.CurrentK;
if strcmp(type,'TodayClose')==1
    OrderDay = 0;
elseif strcmp(type, 'NextOpen')==1
    if I+1<=DB.NK
        OrderDay = 1;
    else
        return;
    end
end
if volume > 0
    ordertype = '����';
else
    ordertype = '����';
end
flag = 0;
Data=getfield(DB,[stock(8:9) stock(1:6)]);
for k=0:Options.DelayDays % ����ʧ�����ӳٽ���
    if I+OrderDay+k <= DB.NK
        cond(1) = strcmp(Data.Sec_status{I+OrderDay+k},'L')==1;
        cond(2) = strcmp(Data.Trade_status{I+OrderDay+k},'����')==1;
        cond(3) = -9.9<=Data.Pct_chg{I+OrderDay+k};
        cond(4) = Data.Pct_chg{I+OrderDay+k}<=9.9;
        if cond(1) && cond(2) && cond(3) && cond(4)
            flag = 1;
            break;
        else
            if cond(1)==0
                reason = 'δ���л�����';
            end
            if cond(2)==0
                reason = 'ͣ��';
            end
            if cond(3)==0
                reason = '��ͣ';
            end
            if cond(4)==0
                reason = '��ͣ';
            end
            disp(['Bar' num2str(I) '@' DB.TimesStr(I+OrderDay,:) ' Message: ' stock reason '���½���ʧ�ܣ������ӳ�' num2str(k+1) '��' ordertype]);
        end
    else
        return
    end
end
if flag == 1
    OrderDay = OrderDay + k;
    if I+OrderDay <= DB.NK
        Asset.OrderStock{I+OrderDay} = [Asset.OrderStock{I+OrderDay},{stock}];
        Asset.OrderPrice{I+OrderDay} = [Asset.OrderPrice{I+OrderDay} Data.Close(I+OrderDay)];
        Asset.OrderVolume{I+OrderDay} = [Asset.OrderVolume{I+OrderDay} volume];
    end
end