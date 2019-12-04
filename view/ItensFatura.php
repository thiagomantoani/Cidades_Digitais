<?php
  // Cabeçalho
  include_once("_cabecalho.php");

  // Buscar todos os cadastros no banco
  require_once("../Controller/ControleListarLote.php");
  require_once("../Controller/ControleEntidadeSelect.php");
  // $array_dados
  ?>
  
  <!-- Conteudo -->
  <main id="main">

      <div class="row mb-5">
        <div id="mainHeader" class="col-md-6 d-flex align-items-center">
          <span id="mainHeaderIcon">
          <i class="fas fa-globe-asia"></i>
          </span>
          <span>
            <h3 class="mb-0">Itens Fatura</h3>
            <small>Descrição</small>
          </span>
        </div>
        <div class="col-md-6 text-right">
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".cadastrar-itensfatura-modal-lg">
            <i class="far fa-plus-square"></i>
            Cadastrar
          </button>
        </div>
      </div>

      <div class="container">

          <?php
              // Se a variavél de sessão existir, exibir a informação ela contem
              if(isset($_SESSION['msg'])) {
                  echo $_SESSION['msg']; // Exibir conteudo da variavel
                  unset($_SESSION['msg']); // após exibir a informação do alerta, destruir a variavel, para que ao recarregar a página o alerta não permanessa na pagina.
              }
          ?>

        <div class="row">
          <div class="col-12">
            <!-- Exibir lista de dados em tabela -->
            <div class="table-responsive">
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col">Nota Fiscal</th>
                    <th scope="col">Cód. IBGE</th>
                    <th scope="col">Cód. Empenho</th>
                    <th scope="col">Cód. Item</th>
                    <th scope="col">Cód. Tipo Item</th>
                    <th scope="col">Valor</th>
                    <th scope="col">Quantidade</th>
                    <th scope="col">Ações</th>
                  </tr>
                </thead>
                <tbody>
                <?php
                //var_dump($array_dados);
                //die();
                  foreach ($array_dados as $key => $value) {
                      ?>
                      <tr>
                        <td><?php echo $value['num_nf'] ?></td>
                        <td><?php echo $value['cod_ibge'] ?></td>
                        <td><?php echo $value['cod_empenho'] ?></td>
                        <td><?php echo $value['cod_item'] ?></td>
                        <td><?php echo $value['cod_tipo_item'] ?></td>
                        <td><?php echo $value['valor'] ?></td>
                        <td><?php echo $value['quantidade'] ?></td>
                        <td> 
                          <span class="d-flex">
                          <a href="<?php echo URL ?>View/ItensFaturaEditar.php?cod_lote=<?php echo $value['cod_lote'] ?>" class="btn btn-warning mr-1"> Editar
                          </a>
                          <button onclick="apagarDados('<?php echo URL ?>Controller/ControleApagarLote.php?cod_lote=<?php echo $value['cod_lote'] ?>')" class="btn btn-danger">Excluir</button> 
                          </span>
                        </td>

                      </tr>
                      <?php
                  }
                ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>

      </div>

  </main>

  <!-- Modal de Cadastro -->
  <div class="modal fade cadastrar-itensfatura-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myItensFaturaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        
        <div class="modal-header">
          <h5 class="modal-title" id="myItensFaturaModalLabel">
            <i class="far fa-plus-square"></i>
            Cadastrar Itens da Fatura
          </h5>
        </div>

        <!-- FORMULARIO -->
        <form action="../Controller/ControleItensFatura.php" method="post">

          <div class="modal-body">

            <!-- Input cod_lote -->
            <div class="form-row">
              <div class="form-group col-md-12">
                <label for="recipient-num_nf" class="col-form-label">Nota Fiscal:</label>
                <input
                name="num_nf"
                placeholder=""
                type="number"
                class="form-control"
                maxlength=""
                id="recipient-num_nf">
              </div>



            <div class="form-row">
              <div class="form-group col-md-12">
                <label for="recipient-cod_ibge" class="col-form-label">Municipio:</label>
                      <select name="cod_ibge" class="form-control" id="recipient-cod_ibge">
                      <option value="">Selecionar Municipio</option>
                      <?php 
                        foreach($array_selectCd as $chave => $valor){
                        ?>
                        <option value="<?= $valor['cod_ibge'] ?>"><?= $valor['cod_ibge'] ?></option>
                        <?php 
                        }
                      ?>
                    </select>
              </div>

              <div class="form-row">
              <div class="form-group col-md-12">
                <label for="recipient-cod_empenho" class="col-form-label">Cód. Empenho:</label>
                      <select name="cod_empenho" class="form-control" id="recipient-cod_empenho">
                      <option value="">Selecionar Cód Empenho</option>
                      <?php 
                        foreach($array_selectEmpenho as $chave => $valor){
                        ?>
                        <option value="<?= $valor['cod_empenho'] ?>"><?= $valor['cod_empenho'] ?></option>
                        <?php 
                        }
                      ?>
                    </select>
              </div>

              <div class="form-group col-md-12">
                <label for="recipient-dt_inicio_vig" class="col-form-label">Data inicio da Vigência:</label>
                <input
                name="dt_inicio_vig"
                placeholder=""
                type="date"
                class="form-control"
                maxlength="2"
                id="recipient-dt_inicio_vig">
              </div>

              <div class="form-group col-md-12">
                <label for="recipient-dt_final_vig" class="col-form-label">Data final da Vigência:</label>
                <input
                name="dt_final_vig"
                placeholder=""
                type="date"
                class="form-control"
                maxlength="15"
                id="recipient-dt_final_vig">
              </div>
           
              <div class="form-group col-md-12">
                <label for="recipient-dt_reajuste" class="col-form-label">Data Reajuste:</label>
                <input
                name="dt_reajuste"
                placeholder="dd-mm"
                type="text"
                class="form-control"
                maxlength="8"
                id="recipient-dt_reajuste">
              </div>
            </div>

            <div class="modal-footer">
              <button class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary">
                Cadastrar
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
<?php
    // Rodape
    include_once('_rodape.php');
?>