Для подписи файлов по ГОСТ Р 34.10-2012 вам надо иметь установленный КриптоПРО CSP https://www.cryptopro.ru/products/csp и сертификат с поддержкой ГОСТ Р 34.10-2012.
TfrxFileSignature имеет 3 метода подписания: SignByCryptoAPI, SignByCryptoProSDK и SignByCryptoAPIStampByCryptoProSDK.

SignByCryptoAPI не поддерживает CADES_X_LONG_TYPE_1, но зато не требует CryptoPro CSP и CryptoPro ЭЦП Runtime.
SignByCryptoProSDK и SignByCryptoAPIStampByCryptoProSDK для CADES_T и CADES_X_LONG_TYPE_1 требуют дополнительно CryptoPro TSP и CryptoPro OCSP. Эти продукты автоматически устанавливаются вместе с CryptoPro CSP, но работают только триальный период - потом нужно покупать отдельные лицензии.

32-x битная версия CryptoPro ЭЦП Runtime устанавливается вместе с CryptoPro CSP в папку "c:\Program Files (x86)\Crypto Pro\CAdES Browser Plug-in", ее можно использовать оттуда.

Если у Вас 64-х битное приложение, Вам надо установить 64-х битный CryptoPro ЭЦП Runtime (https://www.cryptopro.ru/downloads) и подключить 64-х битную cades.dll, в нашем примере в TForm1.SignByCryptoAPIButtonClick после FS := TfrxFileSignature.Create(... добавить FS.SetCryptoProSDKPath('C:\Windows\WinSxS\Fusion\amd64_cryptopro.pki.cades_a6d31b994cfcddc4_none_6e142348064635f4\2.0\2.0.14271.0\cades.dll'); В Вашем случае путь может быть другим.
Аналогично можно подключить и 32-х битную cades.dll (проще использовать из установки КриптоПРО CSP).

Про интеграцию CryptoPro ЭЦП Runtime в свой инсталлятор написано тут https://docs.cryptopro.ru/cades/usage и тут https://docs.cryptopro.ru/cades/usage/mergemodules.

Мы рекомендуем использовать:

SignByCryptoAPI, SignByCryptoProSDK или SignByCryptoAPIStampByCryptoProSDK:
  - CAdES_BES

SignByCryptoAPI:
  - CAdES_T + сетификат не ГОСТ + TSA не ГОСТ

SignByCryptoProSDK или SignByCryptoAPIStampByCryptoProSDK:
  - CAdES_T + сетификат ГОСТ + TSA ГОСТ
  - CADES_X_LONG_TYPE_1 + сетификат ГОСТ + TSA ГОСТ
