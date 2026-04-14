# 📦 Entrega Completa no GitHub com APK Pronto (Cria do Tatame)

Este guia transforma o projeto em um repositório **pronto para build e download do APK** via GitHub Actions + GitHub Releases.

## 1) Estrutura mínima obrigatória

```text
.
├─ project.godot
├─ export_presets.cfg
├─ .github/workflows/build-android-apk.yml
├─ scripts/bootstrap_release.sh
├─ build/
└─ docs/release/CHECKLIST_RELEASE.md
```

> O workflow deste repositório já foi incluído em `.github/workflows/build-android-apk.yml`.

## 2) Segredos (Secrets) no GitHub

No repositório GitHub, configure em **Settings → Secrets and variables → Actions**:

- `ANDROID_KEYSTORE_B64` (keystore em base64)
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

### Gerar base64 da keystore

```bash
base64 -w 0 android-release.keystore > keystore.b64
```

## 3) Publicar o repositório

```bash
git init
git add .
git commit -m "chore: setup full github apk delivery pipeline"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPO.git
git push -u origin main
```

## 4) Build do APK no GitHub

1. Vá em **Actions → Build Android APK**.
2. Clique em **Run workflow**.
3. Aguarde o job `build-apk`.
4. Baixe o artefato `app-release-apk`.

## 5) Release pública para download

Crie uma tag semântica para anexar automaticamente o APK na página de Releases:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Depois disso, o workflow anexa `build/app-release.apk` na release `v1.0.0`.

## 6) Checklist de qualidade (antes de publicar)

- APK instala em Android real
- Jogo abre sem crash no menu e partida
- Performance alvo (60 FPS quando aplicável)
- Áudio balanceado e sem clipping
- UI legível em telas pequenas e grandes
- Privacy policy e descrição da loja prontas

## 7) Resultado final esperado

- Repositório GitHub com CI/CD funcional
- APK de release baixável por qualquer pessoa
- Processo repetível para novas versões
