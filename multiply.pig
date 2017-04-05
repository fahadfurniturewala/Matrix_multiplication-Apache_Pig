MMatrix = LOAD '$M' USING PigStorage(',') AS (mrow, mcol, mval);
NMatrix = LOAD '$N' USING PigStorage(',') AS (nrow, ncol, nval);
J = JOIN MMatrix BY mcol FULL OUTER, NMatrix BY nrow;
K = FOREACH J GENERATE mrow,ncol,(mval*nval) AS val;
FMatrix = GROUP K BY (mrow,ncol);
F = FOREACH FMatrix GENERATE FLATTEN(group), SUM(K.val);
STORE F INTO '$O' USING PigStorage (',');
