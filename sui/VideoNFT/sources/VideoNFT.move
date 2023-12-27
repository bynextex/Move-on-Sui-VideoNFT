module nft::video_nft {
    use sui::url::{Self, Url};
    use std::string;
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// Herkes tarafindan uretilebilecek ornek bir NFT
    struct VideoNFT has key, store {
        id: UID,                    // NFT'nin benzersiz kimligi
        name: string::String,       // Token'in adi
        description: string::String, // Token'in aciklamasi
        url: Url,                   // Token'in URL'si
        duration: u8,               // Video suresi 5 saniye olarak varsayalim
        // TODO: ozel ozelliklere izin ver
    }

    // ===== Events =====

    struct NFTMinted has copy, drop {
        object_id: ID,      // NFT'nin Object ID'si
        creator: address,   // NFT'yi olusturan kisinin adresi
        name: string::String, // NFT'nin adi
        duration: u8,       // Video suresi
    }

    // ===== Public view functions - GETTERs =====

    /// NFT'nin `adini` al
    public fun name(nft: &VideoNFT): &string::String {
        &nft.name
    }

    /// NFT'nin `ozelligini` al
    public fun description(nft: &VideoNFT): &string::String {
        &nft.description
    }

    /// NFT'nin `url` ozelligini al
    public fun url(nft: &VideoNFT): &Url {
        &nft.url
    }

    /// NFT'nin `suresini` al
    public fun duration(nft: &VideoNFT): u8 {
        nft.duration
    }

    // ===== Entrypoints =====

    /// Yeni bir video NFT'si olustur
    public fun mint_video_nft(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        let nft = VideoNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
            duration: 5, // 5 saniye sure (varsayilan)
        };

        // NFTMinted event'ini tetikle
        event::emit(NFTMinted {
            object_id: object::id(&nft),
            creator: sender,
            name: nft.name,
            duration: nft.duration,
        });

        // NFT'yi cagiran kisiye transfer et
        transfer::public_transfer(nft, sender);
    }

    /// 'nft'yi 'alici'ya aktar
    public fun transfer(
        nft: VideoNFT, recipient: address, _: &mut TxContext
    ) {
        transfer::public_transfer(nft, recipient)
    }

    /// 'nft'nin 'aciklamasini' 'yeni_aciklama' olarak guncelle
    public fun update_description(
        nft: &mut VideoNFT,
        new_description: vector<u8>,
        _: &mut TxContext
    ) {
        nft.description = string::utf8(new_description)
    }

    /// 'nft'yi kalici olarak sil
    public fun burn(nft: VideoNFT, _: &mut TxContext) {
        let VideoNFT { id, name: _, description: _, url: _, duration: _ } = nft;
        object::delete(id)
    }
}
