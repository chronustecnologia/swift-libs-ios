
project:
	@echo "🚀🚀 Iniciando a geração do projeto com XcodeGen. 🚀🚀"
	xcodegen generate
	@echo "🚀🚀 Instalando pods e atualizando repositórios. 🚀🚀" && \
	pod install --repo-update
	@echo "🚀🚀 Abrindo o workspace do Xcode. 🚀🚀"
	open SwiftLibs.xcworkspace
	@echo "🚀🚀Processo concluído. 🚀🚀"

reset:
	@echo "🚀🚀 Limpando arquivos 🚀🚀"
	git clean -ffdx
	make project