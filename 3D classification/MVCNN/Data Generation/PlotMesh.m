function h = plotMesh(model, style, az, el)
    if strcmpi(style, 'mesh')    
        h = trimesh(model, 'FaceColor', 'none', 'EdgeColor', 'w', ...
            'AmbientStrength', 0.4, 'EdgeLighting', 'flat');    
        set(gcf, 'Color', 'k', 'Renderer', 'OpenGL');
        set(gca, 'Projection', 'perspective');    
        axis equal;
        axis off;
        view(az,el);    
    elseif strcmpi(style, 'solid')
        h = trimesh(model, 'FaceColor', 'w', 'EdgeColor', 'none', ...
            'AmbientStrength', 0.3, 'DiffuseStrength', 0.6, 'SpecularStrength', 0.0, 'FaceLighting', 'flat');
        set(gcf, 'Color', 'w', 'Renderer', 'OpenGL');
        set(gca, 'Projection', 'perspective');    
        axis equal;
        axis off;
        view(az,el);
        camlight('HEADLIGHT');    
    elseif strcmpi(style, 'solidphong')
        h = trimesh(model, 'FaceColor', 'w', 'EdgeColor', 'none', ...
            'AmbientStrength', 0.3, 'DiffuseStrength', 0.6, 'SpecularStrength', 0.0, 'FaceLighting', 'gouraud', ...
            'BackFaceLighting', 'reverselit');
        set(gcf, 'Color', 'w', 'Renderer', 'OpenGL');
        set(gca, 'Projection', 'perspective');    
        axis equal;
        axis off;
        view(az,el);
        camlight('HEADLIGHT'); 
    else
        h = trimesh(model, 'EdgeColor', 'none', ...
            'FaceColor', 'interp' );
        set(gcf, 'Color', 'w', 'Renderer', 'OpenGL');
        set(gca, 'Projection', 'perspective');    
        axis equal;
        axis off;
        view(az,el);
        camlight;
    end
end
