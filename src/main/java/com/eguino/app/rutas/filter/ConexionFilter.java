package com.eguino.app.rutas.filter;

import com.eguino.app.rutas.utils.ConexionBD;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;
import java.sql.Connection;

@WebFilter("/*")
public class ConexionFilter implements Filter {

    private Connection getConnection(){
        return ConexionBD.getInstance();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        Connection conn = this.getConnection();
        servletRequest.setAttribute("conn",conn);
        try{
            filterChain.doFilter(servletRequest,servletResponse);
        } catch (IOException e){
            throw new RuntimeException(e);
        } catch (ServletException e){
            throw new RuntimeException(e);
        }
    }
}
