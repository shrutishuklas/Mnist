function [train_result_matrix,split_col,split_col_code,Entropy_child] =compare_entropy_split_result(train_result_matrix,Entropy_b_split1,Entropy_m_split1,Train_Set,DistSample_frst_norm_b,DistSample_frst_norm_m,threshold_dist_b,threshold_dist_m)
result_col=size((train_result_matrix),2)-3;
if Entropy_b_split1 <= Entropy_m_split1


    for count = 1: size(Train_Set,2)

        if DistSample_frst_norm_b(count) < threshold_dist_b
            train_result_matrix(count,result_col)=2;
        else
            train_result_matrix(count,result_col)=4;
        end
    end
    split_col=size((train_result_matrix),2)-1;

    split_col_code=2;
    Entropy_child=Entropy_b_split1;
else
    for count = 1: size(Train_Set,2)

        if DistSample_frst_norm_m(count) < threshold_dist_m
            train_result_matrix(count,result_col)=4;
        else
            train_result_matrix(count,result_col)=2;
        end
    end
    split_col=size((train_result_matrix),2);
    split_col_code=4;
    Entropy_child=Entropy_m_split1;
end