
function raster = rasterFromBehavREV(fileName)

%read excel file
[num,text,raw]=xlsread(fileName);


[len,wid]=size(raw);

%find row that with headers
row=1;
found=0;
while row<=length(raw) && found ==0
    if strcmp(raw{row,1},'Evnt_Time')
        HeaderRow=row;
        found=999;
    elseif row>35000
        found=1;
    else
        row=row+1;
    end
end

%find columns with item name, timestamp
for col=1:wid
    if strcmp(raw{HeaderRow,col},'Item_Name')
        ItemCol=col;
       
    elseif strcmp(raw{HeaderRow,col},'Evnt_Time')
        TimeCol=col;
    end
end
    

%make vectors to store timestamps from trial types
cInd=1;iAInd=1;iBInd=1;

CorrectTrial=[];
IncATrial=[];
IncBTrial=[];

for i=HeaderRow:len
    if raw{i,TimeCol}~=0
        if strcmp(raw{i,ItemCol},'aaaCorrect_Counter')|| strcmp(raw{i,ItemCol},'aabCorrection_Correct_Counter')
            CorrectTrial(cInd)=raw{i,TimeCol};
            cInd=cInd+1;
        elseif strcmp(raw{i,ItemCol},'aaaIncorrect_CounterA') || strcmp(raw{i,ItemCol},'aabCorrection_IncorrectA_Counter')
            IncATrial(iAInd)=raw{i,TimeCol};
            iAInd=iAInd+1;
        elseif strcmp(raw{i,ItemCol},'aabIncorrect_CounterB') || strcmp(raw{i,ItemCol},'aabCorrection_IncorrectB_Counter')
            IncBTrial(iBInd)=raw{i,TimeCol};
            iBInd=iBInd+1;
        end
    end
    
    
end

yyCor=[ones(size(CorrectTrial));zeros(size(CorrectTrial))];
yyCor=yyCor+ones(size(yyCor))*3;

yyInA=[ones(size(IncATrial));zeros(size(IncATrial))];
yyInA=yyInA+ones(size(yyInA));

yyInB=[ones(size(IncBTrial));zeros(size(IncBTrial))];
yyInB=yyInB+ones(size(yyInB))*5;





hold on
red=[1 0 0]; green= [0 .353 0]; blue = [0 0 .753];
plot([CorrectTrial;CorrectTrial],yyCor,'color',red);
plot([IncATrial;IncATrial],yyInA,'color',green);
plot([IncBTrial;IncBTrial],yyInB,'color',blue);
line([0 3600], [4.5 4.5],'color','k')
line([0 3600], [2.5 2.5],'color','k')

xlabel('Time, s')

names = {'Snever';'Snew';'Sprior'};
set(gca, 'xtick',[0:400:3600],'ytick', [1.5 3.5 5.5],'yticklabel',names)
xlim([0 3600])
ylim([1 6])
end
