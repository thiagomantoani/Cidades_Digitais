<?php
/** Description of ClassUsuarioDAO
 * @author Carol */

require_once 'Conexao.php';
class ClassUsuarioDAO {

    public function cadastrar(ClassUsuario $cadastrarUsuario) {
        try {
            $pdo = Conexao::getInstance();
            $sql = "INSERT INTO usuario (cod_usuario, nome, email, status, login, senha) values (?,?,?,?,?,?)";
            $stmt = $pdo->prepare($sql);
            $stmt->bindValue(1, $cadastrarUsuario->getCod_usuario());
            $stmt->bindValue(2, $cadastrarUsuario->getNome());
            $stmt->bindValue(3, $cadastrarUsuario->getEmail());
            $stmt->bindValue(4, $cadastrarUsuario->getStatus());
            $stmt->bindValue(5, $cadastrarUsuario->getLogin());
            $stmt->bindValue(6, $cadastrarUsuario->getSenha());
           
            $stmt->execute();
            return TRUE;
        } catch (PDOException $exc) {
            echo $exc->getMessage();
        }
    }
    
    public function listarUsuario(){
        try {
            $pdo = Conexao::getInstance();
            $sql = "SELECT cod_usuario, nome, email, status, login, senha FROM usuario ORDER BY cod_usuario ASC";
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            return $stmt->fetchAll(); // fetchAll() retorna um array contendo varios dados. 
        } catch (PDOException $ex) {
            return $ex->getMessage();
        }
    }

    // apagar registro pelo id
    public function apagarUsuario(ClassUsuario $apagarUsuario) {
        try {
            $pdo = Conexao::getInstance();
            $sql = "DELETE FROM usuario WHERE cod_usuario = ?";
            $stmt = $pdo->prepare($sql);
            $stmt->bindValue(1, $apagarUsuario->getCod_usuario());
           
            $stmt->execute();
            return TRUE;
        } catch (PDOException $exc) {
            echo $exc->getMessage();
        }
    }

    public function update(ClassUsuario $editarUsuario) {
        try {
            $pdo = Conexao::getInstance();
            $sql = "UPDATE usuario SET nome = ?, email = ?, status = ?, login = ?, senha = ?
            WHERE cod_usuario = ? ";
            $stmt = $pdo->prepare($sql);
            $stmt->bindValue(1, $editarUsuario->getNome());
            $stmt->bindValue(2, $editarUsuario->getEmail());
            $stmt->bindValue(3, $editarUsuario->getStatus());
            $stmt->bindValue(4, $editarUsuario->getLogin());
            $stmt->bindValue(5, $editarUsuario->getSenha());

            $stmt->bindValue(6, $editarUsuario->getCod_usuario());
           
            $stmt->execute();
            return TRUE;
        } catch (PDOException $exc) {
            echo $exc->getMessage();
        }
    }

    public function visualizarUsuario(ClassUsuario $visualizarUsuario){
        try {
            $pdo = Conexao::getInstance();

            $sql = "SELECT * 
            FROM usuario 
            WHERE cod_usuario = ?";

            $stmt = $pdo->prepare($sql);

            $stmt->bindValue(1, $visualizarUsuario->getCod_usuario());

            $stmt->execute();
            return $stmt->fetchAll(); // fetchAll() retorna um array contendo varios dados. 
        } catch (PDOException $ex) {
            return $ex->getMessage();
        }
    }

}
