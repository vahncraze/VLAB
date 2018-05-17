<%@ Page Title="Sobre" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="VLAB.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function () {
            //$('.wrap input').focus(function () {
            //    if ($(this).val() != "") {
            //        $(this).siblings("label").css({ "top": "10px", "font-size": "12px" });
            //    }
            //    else {
            //        $(this).siblings("label").css({ "top": "-10px", "font-size": "16px" });
            //    }
            //})

            $('.wrap input').each(function () {
                if ($(this).val() == "") {
                    $(this).siblings("label").animate({ top: "-10px", font: "16px"}, 5000, function() {
    // Animation complete.
  });
                }
                else {
                    $(this).siblings("label").animate({ top: "10px", font: "12px"}, 5000, function() {
    // Animation complete.
  });
                }
            })

        });
    </script>
    <div class="wrap">
        <label for="cimento">Cimento</label><br />
        <input id="cimento" />
    </div>
    <div class="wrap">
        <label for="cascalho">Cascalho</label><br />
        <input id="cascalho" />
    </div>
    <div class="wrap">
        <label for="piso">Piso</label><br />
        <input id="piso" />
    </div>
    <div style="position: center">
        <a>Calcular!</a>
    </div>
</asp:Content>
