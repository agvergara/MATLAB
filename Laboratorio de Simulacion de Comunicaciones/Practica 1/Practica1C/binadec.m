function signal = binadec(bsignal, ~, b)
counter = 1;
sign = 1;
exp = 0;
aux = 0;
aux2 = [0 0 0 0 0];
aux3 = [0 0 0 0 0];
bits = [0 0 0 0];
len = length(bsignal)/b;
for i=1:len
   for w=1:b
       bits(w) = bsignal(counter);
       counter = counter + 1;
   end
   if bits(1) == 0
       sign = -1;
   end
   aux = bits(2) - log2(b);
   if aux == -1
       aux2 = [0 1 bits(3) bits(4) 0];
   else
       aux2 = [0 0 1 bits(3) bits(4)];
   end
   for k=1:length(aux2);
       aux3(k) = ((2^exp)* aux2(k));
       exp = exp - 1;
   end
   signal(i) = sum(aux3) * sign;
   exp = 0;
   sign = 1;
end
end