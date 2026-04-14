#!/usr/bin/env bash
set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "git não encontrado."
  exit 1
fi

if [ ! -f project.godot ]; then
  echo "project.godot não encontrado. Execute este script na raiz do jogo Godot."
  exit 1
fi

mkdir -p build docs/release

cat > docs/release/CHECKLIST_RELEASE.md <<'EOF'
# Checklist de Release Android

- [ ] Versionamento atualizado em `project.godot`
- [ ] Export preset Android configurado (`export_presets.cfg`)
- [ ] Keystore de release criada e válida
- [ ] Testes manuais executados em dispositivo real
- [ ] Build release gerado (`build/app-release.apk`)
- [ ] APK instalado e validado
- [ ] Changelog atualizado
- [ ] Tag semântica criada (ex.: `v1.0.0`)
- [ ] Release publicada no GitHub com APK anexado
EOF

echo "Estrutura de release criada em docs/release/CHECKLIST_RELEASE.md"
echo "Próximo passo: configurar os secrets no GitHub e rodar workflow 'Build Android APK'."
