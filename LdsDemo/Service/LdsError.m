//
//  LdsError.m
//  LdsDemo
//
//  Created by eren on 28.07.2018.
//  Copyright © 2018 lds. All rights reserved.
//

#import "LdsService.h"

@implementation LdsError
@synthesize description;

+(LdsError*)errorWithDescription:(NSString*)desc{
    LdsError* error = [[LdsError alloc] init];
    error.description = desc;
    return error;
}
+(LdsError*)errorWithDescription:(NSString*)desc withErrorCode:(NSInteger)errCode{
    LdsError* error = [[LdsError alloc] init];
    error.errorCode = errCode;
    error.description = desc;
    return error;
}

-(void)setDescription:(NSString *)desc {
    self->description = desc;
}

+ (void) saveToErrordata:(NSDictionary*)errorData{
    [[NSUserDefaults standardUserDefaults]setValue:errorData forKey:@"errorData"];
}


+(LdsError*)errorWithErrorCode:(ErrorCode)errorCode {
    
    NSDictionary *errorDic=[[NSUserDefaults standardUserDefaults]valueForKey:@"errorData"];
    if (errorDic == nil) {
        errorDic = [self initialErrorLog];
    }
    NSString *objectKey=[NSString stringWithFormat:@"%i", errorCode];
    NSString *desc=[errorDic objectForKey:objectKey];
    
    if (!desc) {
        return [self errorWithDescription:[[self initialErrorLog] objectForKey:objectKey] withErrorCode:errorCode];
    }
    objectKey=[NSString stringWithFormat:@"%i", errorCode];
    desc=[errorDic objectForKey:objectKey];
    
    return [self errorWithDescription:desc withErrorCode:errorCode];
}

+(NSDictionary*)initialErrorLog {
    return @{
             @"3001" : @"İnternet bağlantınız koptu.",
             @"3002" : @"Beklenmeyen bir sorun oldu!",
             @"3003" : @"İçerik bulunamadı.",
             @"3004" : @"Menu içeriği alınamadı.",
             @"3005" : @"Ana sayfa içeriği okunamadı.",
             @"3006" : @"Filtreleme içeriği alınamadı.",
             @"3007" : @"Kullanıcı adı boş geçilemez.",
             @"3008" : @"Parola alanı boş geçilemez.",
             @"3009" : @"E-Posta adresi doğru formatta değil.",
             @"3010" : @"E-Posta adresi boş geçilemez.",
             @"3011" : @"İçeriğin izleme hakları (entitlement) alınamadı.",
             @"3012" : @"İçerik alınamadı",
             @"3013" : @"Airplay - Mirroring özelliğini kapatın.",
             @"3014" : @"İçerik başlatılamadı. Lütfen daha sonra tekrar deneyiniz.",
             @"3015" : @"Beklenmedik bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",
             @"3016" : @"Yayın haklarından dolayı jailbreak yapılmış cihazlarda içerik izlenememektedir.",
             @"3017" : @"Sunucu ile bağlantı kurulamıyor.",
             @"3018" : @"Satınalma işlemi gerçekleştirilemiyor.\nLütfen telefonunuzun satınalma ayarlarını yapılandırınız.",
             @"3019" : @"Tüm alanları doldurmak zorundasınız.",
             @"3020" : @"Cihazınıza tanımlı Apple ID ile daha önce aboneliğiniz bulunmaktadır.\nLütfen farklı bir Apple ID ile yeniden deneyiniz.",
             @"3021" : @"Apple Store bağlantısında sorun oluştu.",
             @"3022" : @"İzleme yapmak için lütfen ödeme bilgilerinizi tamamlayınız.",
             @"3023" : @"Ödeme alınamadığı için %@ tarihinde ödemeniz askıya alınacaktır.",
             @"3024" : @"Ödeme alınamadığı için hesabınız iptal edilmiştir.",
             @"3025" : @"Ödeme alınamadığı için hesabınız askıya alınmıştır. Lütfen kart bilgilerinizi güncelleyiniz.",
             @"3026" : @"üyeliğiniz onaylanmıştır.",
             @"3027" : @"Ödeme alınamadığı için hesabınız askıya alınacaktır. Lütfen ödeme bilgilerinizi kontrol ediniz.",
             @"3028" : @"Ad alanına sadece harf girmeniz gerekmektedir.",
             @"3029" : @"Soyad alanına sadece harf girmeniz gerekmektedir.",
             @"3030" : @"Ad Soyad alanına sadece harf girmeniz gerekmektedir.",
             @"3100" : @"Hatırlatma mailiniz adresinize gönderilmiştir.",
             @"3101" : @"Bu içerik başarıyla favorinize eklenmiştir.",
             @"3102" : @"Bu içerik favori listenizden silinmiştir.",
             @"3103" : @"Bu içeriğin fragmanı henüz hazır değil. Yakın bir zamanda hazırlanacaktır.",
             @"3200" : @"Bu işlem için giriş yapmanız gerekli. Hemen giriş yapmak ister misiniz?",
             @"3201" : @"Uygulama sürümü çok eski. Lütfen güncelleme yapınız.",
             @"3202" : @"Uygulamanın yeni sürümü mevcut.",
             @"3203" : @"Üye olmak için  web sayfasına yönlendirilmeniz gerekiyor.",
             @"3204" : @"Sıradaki programı izlemek ister misiniz?",
             @"3205" : @"\"%@\" izleme listenizden kaldırılsın mı?"
             
             };
}

@end

