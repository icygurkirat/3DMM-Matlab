function C = calcGrad( A,B )
C=A./B;
C(B==0)=0;
end

