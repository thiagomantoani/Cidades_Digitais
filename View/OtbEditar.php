<?php
    include_once("_cabecalho.php");
    require_once("../Controller/ControleOtbVisualizar.php");

    ?>
    
    <main id="main">
    <div class="container">
        <div class="row mb-5">
          <div id="mainHeader" class="col-md-6 d-flex align-items-center">
            <span id="mainHeaderIcon">
            <i class="fas fa-globe-asia"></i>
            </span>
            <span>
              <h3 class="mb-0">Editar Ordem de Transferência Bancária</h3>
             
            </span>
          </div>
 
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

          <?php 
            if(!empty($array_dados)){

              extract($array_dados);
          ?>

          <!-- FORMULARIO -->
          <form action="../Controller/ControleOtbEditar.php" method="post">

            <div class="modal-body">

                  <!-- Chave primaria para saber qual registro editar do banco | input hidden para que o usuario não visualize -->
                  <input name="cod_otb" type="hidden" value="<?php echo $cod_otb ?>"/>

                  <div class="form-group col-md-12">
                    <label for="recipient-cod_otb" class="col-form-label">Código Ordem de transf. Bancária:</label>
                    <input disabled 
                      value="<?php echo $cod_otb ?>"
                      type="text" 
                      class="form-control"
                      maxlength="255" 
                      id="recipient-cod_otb">
                  </div>
                  
                  <div class="form-group col-md-12">
                    <label for="recipient-dt_pgto" class="col-form-label">Data do Pagamento:</label>
                    <input  
                      value="<?php echo $dt_pgto ?>"
                      name="dt_pgto"
                      placeholder=""
                      type="date" 
                      class="form-control"
                      maxlength="" 
                      id="recipient-dt_pgto">
                  </div>


                </div>

            </div>

            <div class="modal-footer">
              <a href="<?php echo URL ?>View/Otb.php" class="btn btn-secondary">Cancelar</a>
              <button type="submit" class="btn btn-primary">
                Salvar
              </button>
            </div>

          </form>

          <?php 
            } // fim do if para verificar se existe dados para editar
          ?>

        </div>

    </main>


   <!-- Modal de Cadastro -->
   <div class="modal fade cadastrar-otb-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myOtbModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          
          <div class="modal-header">
            <h5 class="modal-title" id="myOtbModalLabel">
              <i class="far fa-plus-square"></i>
              Cadastrar Ordem de Transferência Bancária
            </h5>
          </div>

          <!-- FORMULARIO -->
          <form action="../Controller/ControleOtb.php" method="post">

            <div class="modal-body">

                <!-- Input cod_assunto -->
                <div class="form-row">
                 

                  <div class="form-group col-md-12">
                    <label for="recipient-dt_pgto" class="col-form-label">Data do Pagamento:</label>
                    <input 
                      name="dt_pgto"
                      placeholder=""
                      type="date" 
                      class="form-control"
                      maxlength=""
                      id="recipient-dt_pgto">
                  </div>

                </div>
            </div>
            <div class="modal-footer">
              <button class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary">
                Cadastrar
              </button>
            </div>

          </form>

        
        </div>
      </div>
    </div>

    <?php
    // Rodape
    include_once('_rodape.php');
?>