class FalecidosController < ApplicationController
  def new
    @cadastro_id = params[:cadastro_id]
    @cadastro = Cadastro.find(@cadastro_id)

    @falecido = Falecido.new
    @falecido.build_localizacao
    @falecido.filhos.build
    @falecido.casamentos.build
    @falecido.build_certidao_nascimento
    @falecido.build_nascimento_obito
    @falecido.nascimento_obito.testemunhas.build

  	@css = css
  end

  def create
    @cadastro_id = params[:cadastro_id]
    @falecido = Falecido.new(falecido_params)
  	@falecido.cadastro_id = @cadastro_id
    @falecido.valida_filho = params[:deixa_filhos]
    #@falecido.nascimento_obito.valida = params[:nascimento_obito]
    @falecido.valida_casamento = params[:estado_civil]
    @cadastro = Cadastro.find(@cadastro_id)
    @falecido.cadastro_id = @cadastro_id
    if @falecido.save
      @cadastro.falecido = @falecido
      @cadastro.save
      redirect_to new_dados_obito_path(@cadastro_id)
    else
      @css = css
      render 'new'
    end
  end

  private
  def falecido_params
    #todo: incluir filhos, testemunha de nascimento_obito e seus atributos no permit (olhar como vem da view)
    params.require(:falecido).permit(:nome, :sexo, :cor, :naturalidade,
                              :nascimento, :profissao, :documento, :numero_documento, :cpf,
                              :estado_civil, :marca_passo, :eleitor, :reservista, :inss,
                              :inventariar, :testamento, :beneficio, :peso, :altura, :nome_mae,
                              :naturalidade_mae, :estado_civil_mae, :idade_mae, :profissao_mae,
                              :nome_pai, :naturalidade_pai, :estado_civil_pai, :profissao_pai,
                              :idade_pai, :deixa_filhos, localizacao_attributes: [:endereco, :bairro,
                              :numero, :cidade, :complemento, :cep, :estado], nascimento_obito_attributes:
                              [:local_nascimento, :data_nascimento, :hora_nascimento, :avo_paterno, :avo_materno,
                              :avo_paterna, :avo_materna, :semanas_gestacao, :gravidez, testemunha_attributes:
                              [:nome, :estado_civil, :nacionalidade, :profissao, :endereco, :bairro]],
                              casamento_attributes:[:nome, :data_casamento, :cartorio, :cidade, :uf,
                              :livro, :folha, :numero], filho_attributes: [:nome, :categoria_idade, :observacoes],
                              testemunha_attributes: [:nome, :estado_civil, :nacionalidade, :profissao, :endereco,
                              :bairro], testemunha_attributes: [:nome, :estado_civil, :nacionalidade, :profissao,
                              :endereco, :bairro], certidao_nascimento_attributes: [:cartorio, :cidade, :uf, :livro, 
                              :folha, :numero, :obito])
  end

  def css
    {
      barra_filtro: "visited first col-sm-2",
      barra_contratante: "previous visited col-sm-2",
      barra_falecido: "active col-sm-2",
      barra_obito: "next col-sm-2",
      barra_produtos: "col-sm-2",
      barra_notas: "col-sm-2",
    }
  end
end
