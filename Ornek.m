P=[100*rand(2,1000)];
T=P<50;
T=T(1,:).*T(2,:);% Her iki sayı da 50'den küçük ise 1 yoksa sıfır çıkışı veren bir ağ
%Aslında çok basit bir mantıksal ifadenin kuralını öğrenmesini istiyoruz
net = feedforwardnet([4 4 4]);%5 katmanlı ağ(Giriş ve çıkış ile)
net=train(net,P,T);
view(net)
P1 = net (P);
plotconfusion(T,P1)



%im=>çizilen resim
im=not(im2bw(im));
se = strel('line',11,90);
im=imdilate(im,se);  
im=imdilate(im,se);  
im=imdilate(im,se);  
im=imdilate(im,se);  
im=imresize(im,[28 28],'nearest');
imd=im(:);
imdct=dct(single(imd));
imdct=reshape(imdct,[28 28]);
imFeat=imdct(1:7,1:7);
imFeat=imFeat(:);
a=sim(net,imFeat);