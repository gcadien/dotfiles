"unlet b:current_syntax
"syntax include @Yaml syntax/yaml.vim
"syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
"
syntax include @yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/%^---$/ end=/\v^%(.{3}|-{3})$/ keepend contains=@yaml
