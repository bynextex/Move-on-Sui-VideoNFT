# Move on Sui VideoNFT
 
VideoNFT Struct'ı: VideoNFT adında bir struct tanımlanmıştır. Bu struct, videonun temel özelliklerini içerir: ID, isim, açıklama, URL, ve süre (varsayılan olarak 5 saniye).

NFTMinted Event'i: NFTMinted adında bir event tanımlanmıştır. Bu event, yeni bir NFT'nin oluşturulduğunda tetiklenir ve oluşturulan NFT'nin bilgilerini içerir: Object ID, oluşturan kişinin adresi, isim, ve süre.

Public View Functions - Getter'lar: NFT'nin özelliklerini döndüren bir dizi public view function tanımlanmıştır. name, description, url, ve duration bu fonksiyonlardır.

"VideoNFT" struct'ına 5 saniye süresini ve "NFTMinted" event'ine bu süreyi eklemektedir.
