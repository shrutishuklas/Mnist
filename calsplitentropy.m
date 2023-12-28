function [Entropy_b_split1,Entropy_m_split1] =calsplitentropy(train_result_matrix,numbenign,nummalignant)
b_col=size((train_result_matrix),2)-1;
m_col=size(train_result_matrix,2);
%%%%%%% for split 1 as b results in 4th col %%%%%%%%%%%%%
train_result_matrix;
b_num=size(train_result_matrix(train_result_matrix(:,b_col)==2),1);
m_num=size(train_result_matrix(train_result_matrix(:,b_col)==0),1);


prob_b1= b_num/(numbenign+nummalignant);
prob_b2= m_num/(numbenign+nummalignant);

bb1=(train_result_matrix(train_result_matrix(:,b_col)==2,:));


cond_prob_b_splitb1= size(find(bb1(:,1)==2),1)/(size(find(train_result_matrix(:,b_col)==2),1));
cond_prob_b_splitb2=size(find(bb1(:,1)==4),1)/(size(find(train_result_matrix(:,b_col)==2),1));

bb2=(train_result_matrix(train_result_matrix(:,b_col)==0,:));
cond_prob_b_splitb3= size(find(bb2(:,1)==2),1)/(size(find(train_result_matrix(:,b_col)==0),1));
cond_prob_b_splitb4= size(find(bb2(:,1)==4),1)/(size(find(train_result_matrix(:,b_col)==0),1));


if isnan(cond_prob_b_splitb1) || (cond_prob_b_splitb1==0)
  cond_prob_b_splitb1=1;
end

if isnan(cond_prob_b_splitb2) || (cond_prob_b_splitb2==0)
    cond_prob_b_splitb2=1;
end   

if isnan(cond_prob_b_splitb3) || (cond_prob_b_splitb3==0)
    cond_prob_b_splitb3=1;
end

if isnan(cond_prob_b_splitb4) || (cond_prob_b_splitb4==0)
    cond_prob_b_splitb4=1;
end

% 
% cond_prob_b_splitb1 = b1_nan  + b1_notnan *cond_prob_b_splitb1
% cond_prob_b_splitb2 = b2_nan + b2_notnan*cond_prob_b_splitb2
% cond_prob_b_splitb3 = b3_nan + b3_notnan*cond_prob_b_splitb3
% cond_prob_b_splitb4 = b4_nan + b4_notnan*cond_prob_b_splitb4


class_prob_b1 = [cond_prob_b_splitb1 cond_prob_b_splitb2];
class_prob_b2= [cond_prob_b_splitb3 cond_prob_b_splitb4];



Entropy_b_split1 = (prob_b1 * (-sum(class_prob_b1 .* log2(class_prob_b1)))) + (prob_b2 * (-sum(class_prob_b2 .* log2(class_prob_b2))));

%%%%%%% for split 1 as m results in 5th col %%%%%%%%%%%%%
size(find(train_result_matrix(:,m_col)==4),1);
size(find(train_result_matrix(:,m_col)==0),1);
prob_m1= size(find(train_result_matrix(:,m_col)==4),1)/(numbenign+nummalignant);
prob_m2= size(find(train_result_matrix(:,m_col)==0),1)/(numbenign+nummalignant);
mm1=(train_result_matrix(find(train_result_matrix(:,m_col)==4),:));

cond_prob_m_splitm1= size(find(mm1(:,1)==2),1)/(size(find(train_result_matrix(:,m_col)==4),1));
cond_prob_m_splitm2= size(find(mm1(:,1)==4),1)/(size(find(train_result_matrix(:,m_col)==4),1));

mm2=(train_result_matrix(find(train_result_matrix(:,m_col)==0),:));
cond_prob_m_splitm3= size(find(mm2(:,1)==2),1)/(size(find(train_result_matrix(:,m_col)==0),1));
cond_prob_m_splitm4= size(find(mm2(:,1)==4),1)/(size(find(train_result_matrix(:,m_col)==0),1));



if isnan(cond_prob_m_splitm1) || (cond_prob_m_splitm1==0)
  cond_prob_m_splitm1=1;
end

if isnan(cond_prob_m_splitm2) || (cond_prob_m_splitm2==0)
    cond_prob_m_splitm2=1;
end   

if isnan(cond_prob_m_splitm3) || (cond_prob_m_splitm3==0)
    cond_prob_m_splitm3=1;
end

if isnan(cond_prob_m_splitm4) || (cond_prob_m_splitm4==0)
    cond_prob_m_splitm4=1;
end

class_prob_m1 = [cond_prob_m_splitm1 cond_prob_m_splitm2];
class_prob_m2= [cond_prob_m_splitm3 cond_prob_m_splitm4];

Entropy_m_split1 = (prob_m1 * (-sum(class_prob_m1 .* log2(class_prob_m1)))) + (prob_m2 * (-sum(class_prob_m2 .* log2(class_prob_m2))));

end
