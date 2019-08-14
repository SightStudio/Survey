package com.common.component.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

/**
 * 파일 다운로드를 위한 커스텀 view
 * 
 * @since  2019.07.26
 */
@Component
public class DownloadView extends AbstractView{
	
	public DownloadView() {
        setContentType("application/download; charset=utf-8");
    }
	
	@Override
	protected void renderMergedOutputModel( Map<String, Object> model, 
										    HttpServletRequest request,
										    HttpServletResponse response) throws Exception {

		// [1] 파라미터 세팅
		File    file     = (File) model.get("downloadFile");	// 다운로드 될 파일
        String  header   = request.getHeader("User-Agent");		// HTTP User-Agent Header
        boolean isIE     = header.indexOf("MSIE") > -1;			// check browser is not IE

        String  fileName = isIE ? URLEncoder.encode(file.getName(), "utf-8") 
						        : new String(file.getName().getBytes("utf-8"), "iso-8859-1");
        
        // [2] 응답 헤더세팅
        response.setContentType(getContentType());
        response.setContentLength((int) file.length()); 
        response.setHeader("Conent-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transter-Encoding", "binary");

        // [3] 결과물 렌더링
        OutputStream    out = response.getOutputStream();
        FileInputStream fis = null;
        
        try {
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException ioe) {
                    ioe.printStackTrace();
                }
            }
            out.flush();
        }
    } 
} 
