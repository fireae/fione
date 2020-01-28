<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><%@taglib prefix="fi"
	uri="http://fione.codelibs.org/functions"
%><!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><la:message key="labels.fione_brand_title" /> | <la:message key="labels.easyml" /></title>
<jsp:include page="/WEB-INF/view/common/admin/head.jsp"></jsp:include>
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<jsp:include page="/WEB-INF/view/common/admin/header.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/view/common/admin/sidebar.jsp">
			<jsp:param name="menuCategoryType" value="fione" />
			<jsp:param name="menuType" value="easyml" />
		</jsp:include>
		<div class="content-wrapper">
			<section class="content-header">
				<h1><la:message key="labels.easyml_prediction_summary" arg0="${f:h(project.name)}" /></h1>
				<ol class="breadcrumb">
					<li><la:link href="../dataset">
							<la:message key="labels.easyml_dataset" />
						</la:link></li>
					<li><la:link href="../train/${f:u(projectId)}?did=${f:u(dataSetId)}">
							<la:message key="labels.easyml_data_analysis" />
						</la:link></li>
					<li class="active"><la:message key="labels.easyml_summary" /></li>
				</ol>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<la:info id="msg" message="true">
							<div class="alert alert-info">${msg}</div>
						</la:info>
						<la:errors />
					</div>
					<div class="col-md-3">
						<div class="info-box">
							<span class="info-box-icon bg-aqua"><i class="fas fa-table"></i></span>
							<div class="info-box-content">
								<span class="info-box-number"><la:message key="labels.easyml_x_rows" arg0="${f:h(columnSummaries.rows)}" /></span>
								<span class="info-box-number"><la:message key="labels.easyml_x_columns" arg0="${f:h(columnSummaries.numColumns)}" /></span>
								<div style="overflow: hidden;text-overflow: ellipsis;">${fi:frameName(frameId)}</div>
							</div>
						</div>
						<div class="info-box">
							<span class="info-box-icon bg-green"><i class="fas fa-hammer"></i></span>
							<div class="info-box-content">
								<span class="info-box-number"><la:message key="labels.easyml_x_models" arg0="${fn:length(leaderboard.models)}" /></span>
								<div style="overflow: hidden; text-overflow: ellipsis;">
									<span class="label label-success"><la:message key="labels.easyml_best" /></span> ${leaderboard.models[0].name}
								</div>
							</div>
						</div>
						<div class="info-box">
							<span class="info-box-icon bg-yellow"><i class="fas fa-chart-line"></i></span>
							<div class="info-box-content">
								<span class="info-box-number">${f:h(predictionMetric.name)} ${fi:formatNumber(predictionMetric.value,"%.8f")}</span>
								<span class="label label-warning"><la:message key="labels.easyml_accuracy" /></span>
								<span style="color:#ffbb00;"><c:choose>
									<c:when test="${predictionMetric.accuracy<=0.2}"><i                             class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i></c:when>
									<c:when test="${predictionMetric.accuracy>0.2 and predictionMetric.accuracy<=0.4}"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i></c:when>
									<c:when test="${predictionMetric.accuracy>0.4 and predictionMetric.accuracy<=0.6}"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i></c:when>
									<c:when test="${predictionMetric.accuracy>0.6 and predictionMetric.accuracy<=0.8}"><i  class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i></c:when>
									<c:when test="${predictionMetric.accuracy>0.8}"><i                              class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></c:when>
								</c:choose></span>
							</div>
						</div>
						<c:if test="${fn:length(dataSets) gt 0}">
							<div class="box box-primary">
								<div class="box-header with-border">
									<h3 class="box-title"><la:message key="labels.easyml_datasets" /></h3>
									<div class="box-tools pull-right">
										<button type="button" class="btn btn-box-tool" data-widget="collapse">
											<i class="fa fa-minus"></i>
										</button>
									</div>
								</div>
								<div class="box-body">
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-bordered table-striped">
												<thead>
													<tr>
														<th><la:message key="labels.automl_name" /></th>
														<th class="col-sm-4 text-center"><la:message key="labels.easyml_action" /></th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="data" varStatus="s" items="${dataSets}">
														<tr>
															<form method="post" action="${contextPath}/admin/easyml/">
																<input type="hidden" name="lastaflute.action.TRANSACTION_TOKEN" value="${f:h(token)}"> <input
																	type="hidden" name="projectId" value="${f:h(project.id)}"
																> <input type="hidden" name="dataSetId" value="${f:h(data.id)}"> <input type="hidden"
																	name="frameId" value="${f:h(frameId)}"
																> <input type="hidden" name="leaderboardId" value="${f:h(leaderboardId)}">
																<td><i class="fas fa-chart-line" title="Test Data"></i> ${f:h(data.name)}</td>
																<td class="text-center">
																	<button type="submit" name="downloaddataset" value="download" class="btn btn-link" style="padding: 0;">
																		<i class="fas fa-download" title="Download"></i>
																	</button>
																	<button type="submit" name="deletedataset" value="Delete" class="btn btn-link" style="padding: 0;">
																		<i class="fas fa-trash-alt" title="Delete"></i>
																	</button>
																</td>
															</form>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</div>
					<div class="col-md-9">
						<div class="box box-info">
							<div class="box-header with-border">
								<h3 class="box-title"><la:message key="labels.easyml_reports" /></h3>
								<div class="btn-tools pull-right">
									<button type="button" class="btn btn-box-tool" data-widget="collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
							</div>
							<div class="box-body">
								<jsp:include page="/WEB-INF/view/admin/easyml/admin_easyml_summary_report.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="/WEB-INF/view/common/admin/footer.jsp"></jsp:include>
	</div>
	<jsp:include page="/WEB-INF/view/common/admin/foot.jsp"></jsp:include>
</body>
</html>
