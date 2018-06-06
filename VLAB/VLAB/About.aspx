<%@ Page Title="Sobre" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="VLAB.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function () {

            $('#div-resultado .wrap label').each(function () {

                $(this).css("font-size", "18px");
            })

            $('input').focus(function () {
                $(this).siblings('label').animate({
                    'fontSize': '12px',
                    'top': '5px',
                    'left': '0px'
                }, 100);
            })
            $('input').focusout(function () {
                AtualizarLabel();
            })

            AtualizarLabel = function () {
                $("input").each(function () {
                    if (($(this).val()) != "") {
                        $(this).siblings('label').animate({
                            'fontSize': '12px',
                            'top': '5px',
                            'left': '0px'
                        }, 100);
                    }

                    if ($(this).val() == "") {
                        $(this).siblings('label').animate({
                            'fontSize': '16px',
                            'top': '30px',
                            'left': '5px'
                        }, 100);
                    }
                });
            }

            AtualizarLabel();

            CalcularVagas = function () {
                var altura = $('#altura').val();
                var comprimento = $('#comprimento').val();

                //Parametros fixos.
                var alturaUsada = 0;
                var comprimentoUsado = 0;
                var espacoTotal = altura * comprimento;
                var espacoCorredor = 5.5;
                var comprimentoVaga = 5.5;
                var larguraVaga = 2.5;
                var espacoSaidaVaga = 5.5;// Espaço para manobra.
                var qtdeCorredorHorizontal = 2;//Fixos Cima e Baixo.
                var qtdeCorredorCompleto = 0;
                var qtdeCorredor = 0;
                var areaDeVagas = 0;
                var totalVagas = 0;
                var totalUsado = 0;
                var totalVagasPorColuna = 0;//número correspondente verticalmente por espaço.

                if (altura < (larguraVaga * 2) || comprimento < (comprimentoVaga * 2)) {
                    alert("A área não possui espaço mínimo para alocação de veículos. Valores mínimos aceitáveis:\nAltura = " + (larguraVaga * 2) + "\nComprimento = " + (comprimentoVaga * 2) + ".");
                    return;
                }
                //Cálculo das vagas de canto.
                totalVagas += (altura / larguraVaga) * 2; //Soma as vagas fixas dos cantos esquerdo e direito do estacionamento.
                alturaUsada = larguraVaga * 2;
                comprimentoUsado = comprimentoVaga * 2;
                //Fim

                //Ajustando valores para atender o real cenário.
                totalVagasPorColuna = (altura / larguraVaga) - 4;//Remove 4 vagas correspondentes aos corredores principais de transito.
                totalVagas = totalVagas - 2; // Remove 2 espaços de vagas pois são valores da entrada do estacionamento.
                totalUsado = totalVagas * (comprimentoVaga * larguraVaga * espacoSaidaVaga);// Soma os metros quadrados das vagas alocadas nos cantos do estacionamento.
                //Fim

                while (alturaUsada < altura && comprimentoUsado < comprimento) {

                    if ((comprimentoUsado + ((comprimentoVaga * 2) + espacoSaidaVaga)) < comprimento) {//Possui espaço para mais um corredor completo.

                        totalVagas += totalVagasPorColuna * 2;//Adiciona um corredor completo ao número de vagas.
                        alturaUsada += larguraVaga * 2;//Adiciona altura usada.
                        comprimentoUsado += (comprimentoVaga * 2) + espacoSaidaVaga;//Adiciona comprimento usado.
                        qtdeCorredorCompleto++;
                        areaDeVagas += (larguraVaga * comprimentoVaga) * (totalVagasPorColuna * 2);
                    }
                    else {
                        if ((comprimentoUsado + comprimentoVaga + (espacoSaidaVaga / 2)) < comprimento) {//Possui espaço para meio corredor;

                            totalVagas += totalVagasPorColuna;//Adiciona um corredor completo ao número de vagas.
                            alturaUsada += larguraVaga;//Adiciona altura usada.
                            comprimentoUsado += comprimentoVaga + (espacoSaidaVaga / 2);//Adiciona comprimento usado.
                            qtdeCorredor++;
                            areaDeVagas += (larguraVaga * comprimentoVaga) * (totalVagasPorColuna);
                        }
                        else {//Não existe mais possibilidades de alocação de vagas, adiciona os valores para sair da condição While.

                            alturaUsada += larguraVaga;//Adiciona altura usada.
                            comprimentoUsado += comprimentoVaga;//Adiciona comprimento usado.
                        }
                    }
                }
                $('#areaTotal').text("Área total: " + espacoTotal);
                $('#qtdeVagasCanto').text("Vagas totais das pontas (VP): " + (((totalVagasPorColuna + 4) * 2) - 2));
                $('#qtdeVagasPorCorredor').text("Vagas por corredor (VC): " + totalVagasPorColuna);
                $('#corredoresCompletos').text("Corredores completos (CC): " + qtdeCorredorCompleto);
                $('#corredores').text("Corredores (C): " + qtdeCorredor);
                $('#areaTotalOcupada').text("Área total ocupada por vagas: " + areaDeVagas);
                $('#resultado').text("Total de vagas (TV): " + totalVagas);
                $('#calculoMatematico').text("Cálculo: (CC * 2 * VC) + VP + (C * VC) = TV");
            }
        });
    </script>
    <div>
        <div class="jumbotron">
            <h1 style="align-items: center">Motor de solução</h1>
        </div>
        <div class="wrap">
            <label for="altura" style="position: relative;">Altura²</label><br />
            <input id="altura" value="" />
        </div>
        <div class="wrap">
            <label for="comprimento" style="position: relative">Comprimento²</label><br />
            <input id="comprimento" />
        </div>
        <div style="position: center; margin-top: 20px">
            <a style="cursor: pointer" onclick="CalcularVagas()">Calcular!</a>
        </div>
        <div id="div-resultado">
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="areaTotal" style="position: relative"></label>
                <br />
            </div>
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="areaTotalOcupada" style="position: relative"></label>
                <br />
            </div>
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="qtdeVagasCanto" style="position: relative"></label>
                <br />
            </div>
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="qtdeVagasPorCorredor" style="position: relative"></label>
                <br />
            </div>
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="corredoresCompletos" style="position: relative"></label>
                <br />
            </div>
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="corredores" style="position: relative"></label>
                <br />
            </div>
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="resultado" style="position: relative"></label>
                <br />
            </div>
            <div class="wrap" style="position: center; margin-top: 20px">
                <label id="calculoMatematico" style="position: relative"></label>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
