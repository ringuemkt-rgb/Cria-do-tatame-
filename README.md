Como Compilar o APK do Tatame Game

Opção 1: Compilar no Android Studio (Recomendado)

Pré-requisitos
1. Android Studio - Baixe em: https://developer.android.com/studio
2. Java JDK 11 ou superior
3. Android SDK (instalado automaticamente com o Android Studio)

Passos

1. Extraia o arquivo `tatame-android-project.zip`
   
```
   tatame-android-project/
   ├── android/
   ├── build-apk.sh
   └── README.md
   ```

2. Abra o Android Studio

3. Selecione "Open an existing project"

4. Navegue até a pasta `android/` extraída e abra

5. Aguarde a sincronização do Gradle
   - O Android Studio baixará as dependências automaticamente
   - Isso pode levar alguns minutos na primeira vez

6. Compile o APK
   - Menu: `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)`
   
   Ou para APK de release (assinado):
   - Menu: `Build` → `Generate Signed Bundle / APK...`
   - Selecione "APK"
   - Crie ou selecione um keystore
   - Preencha as informações e clique em "Finish"

7. Localize o APK gerado
   - Debug: `android/app/build/outputs/apk/debug/app-debug.apk`
   - Release: `android/app/build/outputs/apk/release/app-release.apk`

8. Instale no dispositivo
   
```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```

   Ou transfira o arquivo para o dispositivo e instale.

---

Opção 2: Compilar via Linha de Comando (Gradle)

Pré-requisitos
1. Java JDK 11+
2. Android SDK com:
   - SDK Platform (API 24-34)
   - Build-Tools
   - Platform-Tools (adb)

Configuração

1. Configure as variáveis de ambiente:
   
```bash
   export ANDROID_SDK_ROOT=/caminho/para/android-sdk
   export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
   export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools
   ```

2. Edite o arquivo `android/local.properties`:
   
```properties
   sdk.dir=/caminho/para/seu/android-sdk
   ```

Compilação

1. Navegue até a pasta android:
   
```bash
   cd tatame-android-project/android
   ```

2. Dê permissão ao gradlew (Linux/Mac):
   
```bash
   chmod +x gradlew
   ```

3. Compile o APK Debug:
   
```bash
   ./gradlew assembleDebug
   ```

4. Ou compile o APK Release:
   
```bash
   ./gradlew assembleRelease
   ```

5. O APK será gerado em:
   - Debug: `app/build/outputs/apk/debug/app-debug.apk`
   - Release: `app/build/outputs/apk/release/app-release-unsigned.apk`

---

Opção 3: Usar o Script Automático

Linux/Mac

```bash
cd tatame-android-project
chmod +x build-apk.sh
./build-apk.sh
```

Windows

```batch
cd tatame-android-project
android\gradlew.bat assembleDebug
```

---

Instalação no Dispositivo

Via ADB

```bash
adb install -r app/build/outputs/apk/debug/app-debug.apk
```

Via transferência de arquivo
1. Conecte o dispositivo via USB
2. Copie o APK para o dispositivo
3. No dispositivo, abra o arquivo APK
4. Permita instalação de fontes desconhecidas se solicitado
5. Instale o aplicativo

---

Solução de Problemas

Erro: "SDK location not found"
- Verifique se o `local.properties` está configurado corretamente
- Ou defina a variável `ANDROID_SDK_ROOT`

Erro: "Gradle sync failed"
- No Android Studio: `File` → `Sync Project with Gradle Files`
- Ou execute: `./gradlew clean build`

Erro: "Java version mismatch"
- Verifique: `java -version`
- Configure o JAVA_HOME para apontar para JDK 11+

Erro: "Permission denied" no gradlew
- Execute: `chmod +x gradlew`

---

Requisitos do Dispositivo

- Android: 7.0+ (API 24)
- RAM: 2GB+
- Espaço: 20MB
- Tela: Recomendado landscape (horizontal)

---

Assinatura do APK (para distribuição)

Para distribuir o APK na Play Store ou outros canais, você precisa assiná-lo:

```bash
# Gerar keystore
keytool -genkey -v -keystore tatame.keystore -alias tatame -keyalg RSA -keysize 2048 -validity 10000

# Assinar APK
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore tatame.keystore app-release-unsigned.apk tatame

# Otimizar APK
zipalign -v 4 app-release-unsigned.apk tatame-release.apk
```

---

Suporte

Para mais informações, consulte:
- Documentação Android: https://developer.android.com/studio/build
- Gradle: https://docs.gradle.org/