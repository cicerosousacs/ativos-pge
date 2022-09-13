jQuery(document).on 'application:load', ->
  attach_ativo = $('#attach_ativo')
 
  attach_ativo.on 'cocoon:after-insert', (e, added_el) ->
    added_el.find("input").first().focus();
    # COMENTÁRIO: Coloca o foco do cursor no primeiro input do novo objeto
 
  attach_ativo.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 5000)
        el_to_remove.fadeOut(5000)
    # COMENTÁRIO: Cria pequena animação ao apagar uma experiencia