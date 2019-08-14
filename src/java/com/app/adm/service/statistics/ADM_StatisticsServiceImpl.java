package com.app.adm.service.statistics;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;
import com.common.dao.CommonDaoIF;
import com.common.service.BaseService;

@Service
public class ADM_StatisticsServiceImpl extends BaseService 
							           implements ADM_StatisticsServiceIF {
	@Autowired
	CommonDaoIF dao;
	
	@Value("#{common['FILE_PATH']}")
	String filePath;
	
	/**
	 * <pre>
	 *    통계 조회   
	 * </pre>
	 * @since  2019. 7. 26.
	 */
	@Override
	public CommonVO getStatistic(CommonVO param) throws Exception {
		CommonVO result = new CommonVO();
		
		// [1] 통계 리스트 선택
		CommonVOList<CommonVO> statisticList = dao.selectList("com.app.mapper.adm.statistics.getEmpStatistics", null);
		result.put("statisticList", statisticList);

		return result;
	}

	/**
	 * <pre>
	 *   설문지 통계 -> 위반사항 세부내역 목록 조회   
	 * </pre>
	 * @since  2019. 7. 26.
	 */
	@Override
	public CommonVO getSurveyExcuseList(CommonVO param) throws Exception {
		CommonVO result = new CommonVO();
		
		CommonVOList<CommonVO> excuseList = dao.selectList("com.app.mapper.adm.survey.getSurveyExcuseList", param);
		result.put("excuseList", excuseList);
		return result;
	}
	
	/**
	 * <pre>
	 *    설문조사 초기화 함수   
	 * </pre>
	 * @since  2019. 7. 26.
	 */
	@Override
	public CommonVO resetStatistics(CommonVO param) throws Exception {
		CommonVO result = new CommonVO();
		
		// [1] 평가 상태 -> 평가 준비로 변경
		dao.delete("com.app.mapper.common.serverStatus.endSurvey", null);
		
		// [2] 평가지 전부 제거
		dao.update("com.app.mapper.adm.survey.deleteSurveyAll", null);
		
		// [3] 피평가자 매핑 모두 제거 [상태값 변환]
		dao.update("com.app.mapper.adm.subject.deleteAssoSurveyMappingOnlyStatus", null);
		
		// [4] 서버 상태 캐시 refresh
		dao.refreshServerStatus();
		
		return result;
	}

	@Override
	public CommonVO getStatisticInExcel(CommonVO param) throws Exception {
		CommonVO result = new CommonVO();
		File file = new File(filePath+"/temp.xlsx");
		
		// [1] 통계 결과 가져오기
		CommonVOList<CommonVO> empList         = dao.selectList("com.app.mapper.adm.statistics.getEmpList"         , null);
		CommonVOList<CommonVO> answerList      = dao.selectList("com.app.mapper.adm.statistics.getAnswerStatistics", null);
		CommonVOList<CommonVO> sheetHeaderList = dao.selectList("com.app.mapper.adm.statistics.getSheetInfo"       , null);
		CommonVOList<CommonVO> rowCnt          = dao.selectList("com.app.mapper.adm.statistics.getSheetRowCnt"     , null); 
		
		int office_cnt = rowCnt.get(0).getInt("ROW_CNT");
		int field_cnt  = rowCnt.get(1).getInt("ROW_CNT");
		
		int cnt = Math.max(office_cnt, field_cnt);
		
		// [2] 엑셀 파일 생성
		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet("통계");
		
		Row     row = null;
	    Cell   cell = null;
	    int   rowNo = 0;
		
		// [4] [헤더부분] 엑셀 경계선
		CellStyle headStyle = wb.createCellStyle();
		headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	    
		// [헤더부분] 배경색 노란색
		headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

		// [헤더부분] 데이터 가운데 정렬
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		headStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		// [헤더부분] 데이터용 경계 스타일 테두리만 지정
		CellStyle bodyStyle = wb.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		// 헤더 생성
		row = sheet.createRow(rowNo++);
		cell = row.createCell(0);
		cell.setCellStyle(headStyle);
		cell.setCellValue("부서명");
		
		cell = row.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("사번");
		
		cell = row.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("이름");
		
		cell = row.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("직위");

		cell = row.createCell(4);
		cell.setCellStyle(headStyle);
		cell.setCellValue("직책");
		
		sheet.addMergedRegionUnsafe(new CellRangeAddress(0,1,0,0));
		sheet.addMergedRegionUnsafe(new CellRangeAddress(0,1,1,1));
		sheet.addMergedRegionUnsafe(new CellRangeAddress(0,1,2,2));
		sheet.addMergedRegionUnsafe(new CellRangeAddress(0,1,3,4));
		
		int header_1_Cell = 5;
		for(int i = 1 ; i <= cnt; i++) {
			int answer_size = sheetHeaderList.get(i-1).getInt("A_SEQ") == 1 ? 2 : 4;
			for(int j = 0; j < answer_size; j++) {
				cell = row.createCell(header_1_Cell++);
				cell.setCellStyle(headStyle);
				cell.setCellValue(i+"번");
			}
		}
		
		row = sheet.createRow(rowNo++);
		int header_2_Cell = 5;
		String[] yn  = {"예", "아니요"};
		String[] a_4 = {"미흡", "보통", "우수", "탁월"};
		for(int i = 1 ; i <= cnt; i++) {
			int answer_size = sheetHeaderList.get(i-1).getInt("A_SEQ") == 1 ? 2 : 4;
			String[] arr = answer_size == 2? yn : a_4;
			for(int j = 0; j < answer_size; j++) {
				cell = row.createCell(header_2_Cell++);
				cell.setCellStyle(headStyle);
				cell.setCellValue(arr[j]);
			}
		}
		
		int answerIdx = 0;
		
		// 데이터 부분 생성
		for (CommonVO vo : empList) 
		{
			row = sheet.createRow(rowNo++);
			int colIdx = 0;
			
			// [ 컬럼 1 ] 부서명
			cell = row.createCell(colIdx++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(vo.getString("DEPT_NAME"));
			sheet.autoSizeColumn(0);
			
			// [ 컬럼 2 ] 사번			
			cell = row.createCell(colIdx++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(vo.getString("EMP_NO"));
			
			// [ 컬럼 3 ] 이름
			cell = row.createCell(colIdx++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(vo.getString("EMP_NAME"));
			
			// [ 컬럼 4 ] 직위
			cell = row.createCell(colIdx++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(vo.getString("ROLE_NAME"));
			
			// [ 컬럼 5 ] 직책
			cell = row.createCell(colIdx++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(vo.getString("EMP_POSITION"));

			// [ 컬럼 6 ] 지문 번호별 답안
			int empSeq = vo.getInt("SUBJECT_SEQ");
			while(true) {
				int    subjectSeq = answerList.get(answerIdx).getInt("SUBJECT_SEQ");
				String sumAnswer  = answerList.get(answerIdx).getString("SUM_ANSWER");
				
				// [검증 1] 통계 대상과 현재 대상이 같은지 확인
				if(empSeq != subjectSeq) break;
				
				cell = row.createCell(colIdx++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(sumAnswer);
				
				// [검증 2] index length 체크
				if( answerIdx+1 == answerList.size()) break;
				int subjectSeqNext = answerList.get(answerIdx+1).getInt("SUBJECT_SEQ");
				answerIdx++;
				
				// [검증 3] subject 변경시 row change
				if( subjectSeq !=  subjectSeqNext) break; 
			}
		}
		
		OutputStream fos = new FileOutputStream(file);
		wb.write(fos);
		wb.close();
		fos.close();
		
		result.put("downloadFile", file);
		return result;
	}
}
